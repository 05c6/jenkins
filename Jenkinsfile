currentBuild.displayName = "Final_Demo # "+currentBuild.number
pipeline{
        agent any  
	environment{
        VERSION = "${env.BUILD_ID}"
        }
        stages{
              stage('SCM Download'){
                  steps{
                      script{
                    git branch: 'ansible-sonar', url: 'https://github.com/saiarun18/Deekshith_sample-web-application.git'
                  }
                }  
              }

              stage('Quality Gate Statuc Check'){

               agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
            }
                  steps{
                      script{
                      withSonarQubeEnv('sonar') { 
                      sh "mvn sonar:sonar"
                       }
                      timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
		    sh "mvn clean install"
                  }
                }  
	      }
	     stage("docker build & docker push"){
              steps{
                script{
	            sh "cp -r ../Deekshith_MVN_PJT@2/target ."		
                    withCredentials([string(credentialsId: 'docker_nexus_pwd', variable: 'docker_nexus_pwd')]) {
                          sh '''
                                docker build -t 34.71.229.107:8083/springapp:${VERSION} .
                                docker login -u admin -p $docker_nexus_pwd 34.71.229.107:8083
                                docker push  34.71.229.107:8083/springapp:${VERSION}
                                docker rmi 34.71.229.107:8083/springapp:${VERSION}
                            '''
                   }
                }
            }
        }
	stage('ansible playbook'){
			steps{
			 	script{  
				  ansiblePlaybook credentialsId: 'SSH_Jenkins_Pvt_key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts', playbook: 'ansible.yaml'
				}
			}
	}	
    }  
}
