
pipeline {
  agent none
  environment {
    IMAGE = 'test'
    REGISTRY_PASS = credentials("docker-registry-pass")
    SHOPPE = 'nlgm'
    SHKCF = 'ncdbgm'
  }
  stages {
    stage("Build Image") { 
      agent { label 'master'}
      steps {
        sh'''
        docker build -t nodejs:$IMAGE-$BUILD_NUMBER .
	echo env.BRANCH_NAME
	'''
      }
    }
    stage("Push Image to registry"){
      agent { label 'master'}
      steps {
        sh'''
	docker login -u manhnh1995 -p $REGISTRY_PASS
	docker tag nodejs:$IMAGE-$BUILD_NUMBER manhnh1995/nodejs:$IMAGE-$BUILD_NUMBER
	docker push manhnh1995/nodejs:$IMAGE-$BUILD_NUMBER
	'''
      }
    }
    stage("deployment to staging"){
      when {
         branch 'staging' 
      }
      agent { label 'jenkin02'}
      steps {
        sh'''
	docker login -u manhnh1995 -p $REGISTRY_PASS
	docker run -d manhnh1995/nodejs:$IMAGE-$BUILD_NUMBER
	'''
      }
    }
    stage("deployment to produc"){
      when {
        branch "release"
      }
      agent { label 'master'}
      steps {
        sh'''
	sudo sh ./build.sh
	'''
      }
    } 
   }
   post {
        success {
            mail to:"nguyenmanh251995@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
        }
        failure {
            mail to:"nguyenmanh251995@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Boo, we failed."
        }   
   }  
}


