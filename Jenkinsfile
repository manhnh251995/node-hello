
pipeline {
  agent none
  environment {
    IMAGE = 'test'
    REGISTRY_PASS = credentials("docker-registry-pass")
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
      agent { label 'k8s-master'}
      steps {
        sh'''
	docker login -u manhnh1995 -p $REGISTRY_PASS
	docker run -d manhnh1995/nodejs:$IMAGE-$BUILD_NUMBER
	'''
      }
    } 
   }
}
