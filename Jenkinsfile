pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                withEnv(['PATH+EXTRA=/usr/sbin:/usr/bin:/sbin:/bin']) {
                    sh './gradlew build'
                    archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                }
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                withEnv(["PATH+EXTRA=/usr/sbin:/usr/bin:/sbin:/bin"]) {
                    script {
                        docker.withRegistry('https://746135561014.dkr.ecr.us-east-2.amazonaws.com/example-spring', 'ecr:us-east-2:aws-personal') {
                            def promptsImage = docker.build("example-spring")
                            promptsImage.push()
                        }
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }

}
