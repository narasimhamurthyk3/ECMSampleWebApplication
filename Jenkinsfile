pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()   
		NEXUS_URL  = "172.31.34.232:8080"
        IMAGE_URL_WITH_TAG = "narasimhamurthyk/ecm-sample-application:${DOCKER_TAG}"
		VERSION_NUMBER="3.0"

    }
    stages{
	
	
	    stage('Mvn Package'){
        steps {        
            script {
		   echo "this is a IMAGE_URL_WITH_TAG:: ${IMAGE_URL_WITH_TAG}";

 	//sh "ansible-playbook  playbook.yml --extra-vars "${IMAGE_URL_WITH_TAG}\""			    
                Boolean bool = true
                if(bool) {
                    println "The File exists :)"
					echo "this is a IMAGE_URL_WITH_TAG:: ${IMAGE_URL_WITH_TAG}";
					def mvnHome = tool name: 'maven-3', type: 'maven'
					def mvnCMD = "${mvnHome}/bin/mvn"
					sh "${mvnCMD} clean package"
					
                }
                else {
                    println "The File does not exist :("
                }   
            }         
        }
    }
	
	  stage('Publish') {
   
     nexusPublisher nexusInstanceId: 'ecmserver', nexusRepositoryId: 'ECM-SAMPLE-WEB-APP', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'target/ECMSampleApplication.jar']], mavenCoordinate: [artifactId: 'ECMSampleApplication', groupId: 'ecm.sample.web.app', packaging: 'jar', version: '2.0']]]
   }
	

	
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t ${IMAGE_URL_WITH_TAG}"
            }
        }
		
		
			    stage('Run Container on Dev Server'){
					steps {        
						script {
						Boolean bool = true
					if(bool) {
                    			println "The File exists :)"
					echo "this is a IMAGE_URL_WITH_TAG:: ${IMAGE_URL_WITH_TAG}";
					//sh "ansible-playbook  playbook.yml"
					// def image_id = registry + ":$BUILD_NUMBER"
         //  sh "ansible-playbook  playbook.yml --extra-vars "image_name=${IMAGE_URL_WITH_TAG}""
						sh 'pwd'
						sh 'ls'
						sh 'whoami'
						//bash changeTag.sh
						//sh 'bash changeTag.sh'
						sh "chmod +x changeTag.sh"
						sh "./changeTag.sh ${DOCKER_TAG}"
				sh "ansible-playbook  playbook.yml "
					//sh 'docker images'
					sh 'kubeadm version'
					sh 'kubectl version'
					//sh 'kubectl get pods --all-namespaces'
					//sh 'kubectl get pods --all-namespaces'
					sh 'docker stop ecm-sample-application'
					sh 'docker rm ecm-sample-application'					
					def dockerRun = 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
					sh 'docker run -p 8084:8084 -d --name ecm-sample-application ${IMAGE_URL_WITH_TAG}'
					
						
						
						
						}
                else {
                    println "The File does not exist :("
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
