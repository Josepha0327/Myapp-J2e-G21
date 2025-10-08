pipeline {
    agent any
    
    stages {
        
        stage ('Clone'){
            steps{
                
                git credentialsId: 'id_gitlab', url: 'https://repo-dev.efi-academy.com/houcem/myapp-j2e-g18.git'
                
                
            }
            
        }
        
         stage ('Build'){
             steps{
                 withMaven(jdk: 'java', maven: 'maven', traceability: true) {
                         sh 'mvn clean install package'
                   }
             }
         }
        
          stage ('Deploy') {
              steps {
                  deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'id_tomcat', path: '', url: 'http://172.16.18.100:8080')], contextPath: null, war: '**/*.war'
                  
              }
          }
        

     }
       post {

          success {
  
                     echo " Pipline ${env.JOB_NAME} Réussi!!!"

          }

          failure {
                   echo " Echec de Pipline ${env.JOB_NAME}!!!"
                  
          }

       }

   

 
}