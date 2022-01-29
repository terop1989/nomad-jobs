node('master'){
    
        stage('Checkout SCM'){
                checkout scm
        }

        NomadHostName = 'nomad01.local.com'
        NomadJobFile  = 'nginx-alpine.json'
        
	stage('Deploy Job to Nomad'){
                sh """
                   curl \
                   --request POST \
                   --data @${NomadJobFile} \
                   http://${NomadHostName}:4646/v1/jobs
                   """
        }
    
	stage('Clear'){
		deleteDir()
        }
    
}
