pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()   
        IMAGE_URL_WITH_TAG = "narasimhamurthyk/ecm-sample-application:${DOCKER_TAG}"
        //VERSION_NUMBER="3.0"
	    VERSION_NUMBER="${DOCKER_TAG}"
	    

    }
    stages{
	
	    stage('MVN PACKAGE'){
        steps {        
            script {
                Boolean bool = true
                if(bool) {
                    println "The File exists :)"
					echo "this is a IMAGE_URL_WITH_TAG:: ${IMAGE_URL_WITH_TAG}";
					def mvnHome = tool name: 'maven-3', type: 'maven'
					def mvnCMD = "${mvnHome}/bin/mvn"
					sh "${mvnCMD} clean package"
					
                }
               
            }         
        }
    }
	    
	    stage('sonar-scanner') {

steps{

  script {
  def sonarqubeScannerHome = tool name: 'sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
	  withSonarQubeEnv(credentialsId: 'sonar') {
    // some block
		  echo "inside sonarqube******"
}
      withCredentials([string(credentialsId: 'sonar', variable: 'sonarLogin')]) {
	       echo "inside sonarqube#######"
        //sh "${sonarqubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://ecmserver:9000 -Dsonar.login=${sonarLogin} -Dsonar.projectName=gs-gradle -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=GS -Dsonar.sources=complete/src/main/ -Dsonar.tests=complete/src/test/ -Dsonar.language=java -Dsonar.java.binaries=."
	      sh "${sonarqubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://ecmserver:9000 -Dsonar.login=${sonarLogin} -Dsonar.sourceEncoding=UTF-8 -Dsonar.tests=src/test -Dsonar.projectKey=ECMSampleApplication -Dsonar.java.binaries=target/classes -Dsonar.sources=src/main -Dsonar.projectVersion=${env.BUILD_NUMBER}  -Dsonar.language=java -Dsonar.projectBaseDir=/var/lib/jenkins/workspace/ECM-SAMPLE-APPLICATION-JOB"
  
  }
}
}
}
	    
	    
	    
	
	  stage('PUBLISH TO NEXUS') {
	  
	  steps {
		  
    		 //nexusPublisher nexusInstanceId: 'ecmserver', nexusRepositoryId: 'ECM-SAMPLE-WEB-APP', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'target/ECMSampleApplication.jar']], mavenCoordinate: [artifactId: 'ECMSampleApplication', groupId: 'ecm.sample.web.app', packaging: 'jar', version: "${VERSION_NUMBER}"]]]
	  }
   
   }


        stage('BUILD DOCKER IMAGE'){
            steps{
                sh "docker build . -t ${IMAGE_URL_WITH_TAG}"
            }
        }
		
        stage('RUN IMAGE ON DOCKER'){
            steps{
                script {
				
				    sh 'docker stop ecm-sample-application'
					sh 'docker rm ecm-sample-application'					
					def dockerRun = 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
					sh 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
				
			 }
           }
        }
		
			    stage('RUN IMAGE ON KUBERNETES'){
					steps {        
						script {
						Boolean bool = true
					if(bool) {
                   			
					echo "this is a IMAGE_URL_WITH_TAG:: ${IMAGE_URL_WITH_TAG}";
					
					    sh "chmod +x changeTag.sh"
						sh "./changeTag.sh ${DOCKER_TAG}"
						sh "ansible-playbook  playbook.yml "
					
					
					
					    //sh "ansible-playbook  playbook.yml"
					    // def image_id = registry + ":$BUILD_NUMBER"
						// sh "ansible-playbook  playbook.yml --extra-vars "image_name=${IMAGE_URL_WITH_TAG}""
						//sh 'pwd'
						//sh 'ls'
						//sh 'whoami'
						//bash changeTag.sh
						//sh 'bash changeTag.sh'
						
						//sh 'docker images'
						//sh 'kubeadm version'
						//sh 'kubectl version'
						//sh 'kubectl get pods --all-namespaces'
						//sh 'kubectl get pods --all-namespaces'
						//sh 'docker stop ecm-sample-application'
						//sh 'docker rm ecm-sample-application'					
						//def dockerRun = 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
						//sh 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
		
						}
                
            }         
        }
    }
  
 
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
