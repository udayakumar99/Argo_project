pipeline {
    agent any
    tools {
        jdk 'jdk'   // Ensure JDK is installed on Jenkins
        maven 'maven' // Ensure Maven is installed
    }
    environment {
        SCANNER_HOME = tool 'mysonar'
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Clone Repository') {
            steps {
                git 'https://github.com/udayakumar99/Argo_project.git'
            }
        }
        stage('Code Quality Analysis (CQA)') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=ArgoCD_Project \
                    -Dsonar.projectKey=ArgoCD_Project \
                    -Dsonar.java.binaries=target/classes \
                    -Dsonar.tests=src/test/java \
                    -Dsonar.sources=src/main/java \
                    -Dsonar.java.binaries=target/classes
                    '''
                }
            }
        }
        stage('Dependency Check (OWASP)') {
            steps {
                dependencyCheck additionalArguments: '--scan ./target --format XML', 
                        odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Security Scan (Trivy)') {
            steps {
                sh 'trivy fs . > trivyfs.txt'
            }
        }
        stage('Build & Package') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '7643a792-59c0-4068-b7a0-6d91be39cc75') {
                        sh 'docker build -t udayakumar99/argo_project:$BUILD_ID .'
                        sh 'docker push udayakumar99/argo_project:$BUILD_ID'
                    }
                }
            }
        }
        stage('Scan Docker Image') {
            steps {
                sh 'trivy image udayakumar99/argo_project:$BUILD_ID > trivy_image_report.txt'
            }
        }
        stage('Deploy to Kubernetes (ArgoCD)') {
            steps {
                withKubeConfig([credentialsId: 'eea0c190-dffb-46bb-91eb-ea6dab684cec']) {
                    sh 'kubectl apply -f k8s/deployment.yml'
                }
            }
        }
    }
}
