node('docker-agent-dynamic'){
  def IMAGE_NAME = 'my-app'
  def IMAGE_TAG = "${BUILD_NUMBER}"
  def CONTAINER_NAME = 'my-app-container'
  def TEST_PORT = '8000'
  stage('Checkout'){
    echo "Checkout Stage..."
    checkout scm
  }
  stage('Build'){
     
     echo "Building Stage..."
     sh """
       docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
       docker build -t ${IMAGE_NAME}:latest .
     """
  }
  stage('Testing'){
    echo 'Testing Stage...'
    sh """
       docker rm -f ${CONTAINER_NAME} || true

       docker run -d --name ${CONTAINER_NAME} -p ${TEST_PORT}:8000 ${IMAGE_NAME}:${IMAGE_TAG}

       sleep 10

       curl -f http://localhost:${TEST_PORT}/ || exit 1

       response=\$(curl -s http://localhost:${TEST_PORT}/)
       echo "API Response: \$response"

       echo "\$response" | grep -q "processes" || exit 1

       echo "Testing finished successfully"
    """
    

  }
  stage('Container Cleaning'){
    echo 'Cleaning Stage...'
    sh """
      docker stop ${CONTAINER_NAME} || true
      docker rm ${CONTAINER_NAME} || true
    """  

  }

}

