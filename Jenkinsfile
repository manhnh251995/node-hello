
pipeline {
   agent { label 'centos7' }
   //agent any	
   
   environment { 
	   
	DOCKER_IMAGE = 'nodejs/app'
	   
	ECR_REPO = '007293158826.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs'
	APP_VERSION = "${BUILD_ID}"
        APP_ENV = "${BRANCH_NAME}"
       
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
	AWS_DEFAULT_REGION    = 'ap-southeast-1'
	AWS_DEFAULT_OUTPUT    = 'json'
	   
	STAGING_TASK    = 'nodejs-staging-task'
	STAGING_CLUSTER = 'nodejs-staging-cluster'
	STAGING_SERVICE = 'nodejs-staging-srv'
	   
	RELEASE_TASK    = 'nodejs-release-task'
	RELEASE_CLUSTER = 'nodejs-release-cluster'
	RELEASE_SERVICE = 'nodejs-release-srv'
   }

   stages {

      stage('[NODEJS] Build') {
         steps {
            echo '****** Build app ******'
            sh './jenkins/build.sh'
         }
      }
      
      stage('[NODEJS] Push to ECR') {
         steps {
            echo '****** Push docker image to ECR ******'
            sh './jenkins/push.sh'
         }
      }
      
      stage('[NODEJS] Deploy to staging') {
            when {
                branch 'staging' 
	    }
            steps {
		echo "****** Deploy to ${BRANCH_NAME} branch ******"
                sh './jenkins/deploy_staging.sh'
            }
        }
      stage('[NODEJS] Deploy to production') {
           when {
                branch 'release' 
            }
            steps {
		echo "****** Deploy to ${BRANCH_NAME} branch ******"
                sh './jenkins/deploy_release.sh'
            }
        }
   }
}pipeline {
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

