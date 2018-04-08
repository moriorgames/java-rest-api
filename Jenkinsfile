node {
    def app

    stage('Build') {
        echo 'Cloning repository...'
        checkout scm
        echo 'Building Docker image...'
        app = docker.build("moriorgames/java-rest-api")
    }

}
