currentBuild.displayName = "Final_Demo # "+currentBuild.number
pipeline{
        agent any  
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
               }  
}
