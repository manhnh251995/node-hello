pipeline {
  agent none
  environment {
    IMAGE = 'test'
  }
  stages {
    stage("Build Image") { 
      agent { label 'master'}
      steps {
        sh'''
        docker build -t nodejs:$IMAGE-$BUILD_NUMBER  
	'''
      }
    } 
  }
}
