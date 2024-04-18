pipeline{
    
    tools{
        // what tool version to use for build stages
        maven 'mymaven'
    }
    
    agent { label 'jenkins-slave' }

    stages{
        
        stage ('CloneRepo')
        {
            steps{
              git 'https://github.com/RaphDevOps/industry-grade-project.git'  
            }
        }
        
        stage ('Compile')
        {
            steps{
                
             sh  'mvn compile'
                
            }
        }
        stage ('CodeReview')
        {
            steps{
                
             sh  'mvn pmd:pmd'
                
            }
            post{
                success{
                    recordIssues(tools: [pmdParser(pattern: '**/pmd.xml')])
                }
            }
        }
        stage ('TestCode')
        {
            steps{
                
             sh  'mvn test'
                
            }
        post{
            success{
                junit 'target/surefire-reports/*.xml'
            }
        }
        }
        
        stage('packageCode')
        {
            steps{
                sh 'mvn package'
            }
        }
        stage('Build the image') {
            steps {
                sh 'cp /tmp/jenkinsdir/workspace/Industry-grade-project2/target/ABCtechnologies-1.0.war .'
                sh 'docker build -t abctechnologies:$BUILD_NUMBER .'
            }
        }
        stage('Run the application') {
            steps {
                sh 'docker run -d -P abctechnologies:$BUILD_NUMBER'
                sh 'docker ps -a'
            }
        }
        stage('Push the image to Docker Hub') {
            steps {
                sh 'docker tag abctechnologies:$BUILD_NUMBER greatengineer/abctechnologies:$BUILD_NUMBER'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD'
                    sh 'docker push greatengineer/abctechnologies:$BUILD_NUMBER'
                }
            }
        }
    }
    
}
