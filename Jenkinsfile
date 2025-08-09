node('docker-agent-dynamic') {
    def targetenv
    def CONTAINER_NAME = 'my-app-container'
    def DOCKER_TAG
    def DOCKER_HUB_REPOS = 'ahmadhussin/fastapi-process-app'
    def fullImageName

    if (env.JOB_NAME.contains('Prod')) {
        targetenv = 'Prod'
    } else {
        targetenv = 'Dev'
    }

    def config = [
        Prod: [
            defaultbranch: 'main'
        ],
        Dev: [
            defaultbranch: 'Dev'
        ]
    ][targetenv]

    try {
        stage('Checkout') {
            echo 'Checkout Stage...'
            checkout([
                $class: 'GitSCM',
                branches: [[name: config.defaultbranch]],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'CleanCheckout']], // ensures a clean workspace
                userRemoteConfigs: [[
                   url: 'https://github.com/3ahma/DevTrain_QP.git',
                   credentialsId: 'GitHub-Token'
                ]]
            ])

            DOCKER_TAG = "${targetenv}-${env.BUILD_NUMBER}"
            fullImageName = "${DOCKER_HUB_REPOS}:${DOCKER_TAG}"
        }

        stage('Build') {
            dir('PythonTask') {
                echo "Building Stage from within 'python-app/' directory..."
                sh """
                    docker build -t ${fullImageName} .
                """
            }
        }

        stage('Test') {
            echo 'Testing Stage...'
            sh """
                docker rm -f ${CONTAINER_NAME} || true

                docker run -d --name ${CONTAINER_NAME} --network dockercompose_default ${fullImageName}

                sleep 10

                response=\$(curl -s http://${CONTAINER_NAME}:8000/)
            """
        }

        stage('Push to Registry') {
            echo 'Registry Pushing Stage...'
            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sh """
                    echo "\${DOCKER_PASS}" | docker login -u "\${DOCKER_USER}" --password-stdin

                    docker push ${fullImageName}
                """
            }
        }

        stage('Deploy') {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sshagent(credentials: ['vm-ssh-key']) {
                  /* sh '''
                    echo "=== DEBUG: Checking SSH agent keys ==="
                    ssh-add -l || echo "No keys loaded"

                    echo "=== DEBUG: Printing public key being used ==="
                    ssh-add -L || echo "No keys found"

                    echo "=== Attempting SSH connection to VM ==="
                    ssh -o StrictHostKeyChecking=no ahmad@192.168.0.173 "echo SUCCESS: Jenkins key works!"
                   '''*/
                    sh """
                      ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --extra-vars "DOCKER_USER=${DOCKER_USER} DOCKER_PASS=${DOCKER_PASS} FULL_IMAGE_NAME=${fullImageName} DOCKER_HUB_REPO=${DOCKER_HUB_REPOS} targetenv=${targetenv.toLowerCase()}"
                    """
                }
            }
        }
    } catch (e) {
        echo "Error: ${e.message}"
        throw e
    } finally {
        sh """
            docker stop ${CONTAINER_NAME} || true
            docker rm ${CONTAINER_NAME} || true
        """
    }
}
