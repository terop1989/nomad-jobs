node('master'){

	stage('Checkout SCM'){
		checkout scm
	}

	jenkinsAgentDockerfileName = 'run-agent.dockerfile'
	jenkinsAgentBuildName = 'run-agent:latest'
	jenkinsAgentBuildArgs = ''
	jenkinsAgentRunArgs = " -u 0:0"
	def RunAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
        
	stage('Docker Agent'){

		environment {
			NomadHostIP = '192.168.0.112'
		}

		RunAgent.inside("${jenkinsAgentRunArgs}") {
			sshagent (credentials: ['nomad-ssh-agent']) {
					    sh "ansible-playbook nomad-job.yml -e hostname=${NomadHostIP}"
						}
				}
		}

	stage('Clear'){
		deleteDir()
		}
}