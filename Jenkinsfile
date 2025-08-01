node('docker-agent-dynamic'){

  def config = [

     main:[
     
       imagesuffix: 'prod'
     
     ],
     DevBranchPython:[
       imagesuffix: 'dev'
     ]

  ]

  
  def branch_name
  def IMAGE_NAME
  def IMAGE_TAG
  def CONTAINER_NAME

try{
  stage('Checkout'){
    echo "Checkout Stage..."
    checkout scm


    def fullBranchRef = sh(script: 'git name-rev --name-only HEAD', returnStdout: true).trim()
    branch_name = fullBranchRef.split('/').last()
    echo "Successfully checked out branch: '${branch_name}'"
  }

  def ENV_CONFIG = config.get(branch_name, config.DevBranchPython)

  def DOCKER_HUB_USERNAME = 'ahmadhussin'
  IMAGE_NAME = "${DOCKER_HUB_USERNAME}/my-app-${ENV_CONFIG.imagesuffix}"
  IMAGE_TAG = "${BUILD_NUMBER}"
  CONTAINER_NAME = 'my-app-container'
  def TEST_PORT = '8000'

  stage('Build'){
          
    dir('PythonTask') {
      echo "Building Stage from within 'python-app/' directory..."
      sh """
         # Build once, tag twice for efficiency
         docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
         docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
      """
    }
         
    
  }
  stage('Testing'){
    echo 'Testing Stage...'
    sh """
       docker rm -f ${CONTAINER_NAME} || true

       docker run -d --name ${CONTAINER_NAME} --network dockercompose_default ${IMAGE_NAME}:${IMAGE_TAG}

       sleep 10

       #curl -f http://localhost:${TEST_PORT}/ || exit 1

       response=\$(curl -s http://${CONTAINER_NAME}:8000/)
       echo "API Response: \$response"

       echo "\$response" | grep -q "processes" || exit 1

       echo "Testing finished successfully"
    """
    

  }
  stage('Pushing to Registry'){
    echo "Registry Pushing Stage..."
    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){

        sh """
           # Log in to Docker Hub using the credentials
           echo "\${DOCKER_PASS}" | docker login -u "\${DOCKER_USER}" --password-stdin

           # Push the versioned tag
           docker push ${IMAGE_NAME}:${IMAGE_TAG}

           # Push the 'latest' tag
           docker push ${IMAGE_NAME}:latest

           # Log out for security
           docker logout
        """
      
    }

  }

}
catch (e){

     echo "Error: ${e.message}"
     throw e

}
finally{

    sh """
      docker stop ${CONTAINER_NAME} || true
      docker rm ${CONTAINER_NAME} || true
    """
}

}

