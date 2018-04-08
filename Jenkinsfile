node {
    def app

    stage('Build') {
        echo 'Cloning repository...'
        checkout scm
        echo 'Building Docker image...'
        app = docker.build("moriorgames/java-rest-api")
    }

    stage('Test') {
        echo 'Testing...'
        sh 'docker run -td --name java_rest_api -p 8081:8080 moriorgames/java-rest-api'
        sh 'docker exec java_rest_api ./gradlew test'
    }

    stage('Push') {

        sh "docker login -u${DOCKER_REGISTRY_USR} -p${DOCKER_REGISTRY_PWD}"

        sh "docker tag moriorgames/java-rest-api docker.io/moriorgames/java-rest-api:${env.BUILD_NUMBER}"
        sh "docker tag moriorgames/java-rest-api docker.io/moriorgames/java-rest-api:latest"

        sh "docker push docker.io/moriorgames/java-rest-api:${env.BUILD_NUMBER}"
        sh "docker push docker.io/moriorgames/java-rest-api:latest"
    }

    stage('Tear Down') {
        echo 'Removing containers...'
        sh 'docker stop java_rest_api'
        sh 'docker rm java_rest_api'

        echo 'Removing images...'
        sh 'docker rmi moriorgames/java-rest-api --force'
    }
}
