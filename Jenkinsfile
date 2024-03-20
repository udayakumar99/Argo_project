pipeline {
    agent {
  label 's1'
    }

    stages {
        
       stage('git') {
            steps {
                git branch: 'main', url: 'https://github.com/udayakumar99/task2.git'
            }
        }
        stage('mvn run') {
            steps {
                sh "mvn clean install"
            }
        }
        stage('python') {
            steps {
                git branch: 'python', url: 'https://github.com/udayakumar99/task2.git'
            }
        }
        stage('run python') {
            steps {
                sh "python3 main.py"
            }
        }
        stage('shell') {
            steps {
                git branch: 'shell', url: 'https://github.com/udayakumar99/task2.git'
            }
        }
        stage('run shell') {
            steps {
                sh "bash shel.sh"
            }
            
        }
    }
}
