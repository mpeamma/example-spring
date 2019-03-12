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
            steps {
                withEnv(["PATH+EXTRA=/usr/sbin:/usr/bin:/sbin:/bin"]) {
                    script {

                        //cleanup current user docker credentials
                        sh 'rm  ~/.dockercfg || true'
                        sh 'rm ~/.docker/config.json || true'

                        docker.withRegistry('https://746135561014.dkr.ecr.us-east-2.amazonaws.com/example-spring', 'ecr:us-east-2:aws-personal') {
                            def promptsImage = docker.build("scout-services-prompts", "./scout-services-prompts")
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
