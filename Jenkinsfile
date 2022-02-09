node('master'){

		stage('Checkout SCM'){
			checkout scm
		}

		NomadHostName = 'nomad01.local.com'
		NomadHostIP = '192.168.0.112'

	jenkinsAgentDockerfileName = 'run-agent.dockerfile'
	jenkinsAgentBuildName = 'run-agent:latest'
	jenkinsAgentBuildArgs = ''
	jenkinsAgentRunArgs = " -u 0:0 --add-host=\"${NomadHostName}:${NomadHostIP}\""
	def RunAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
        
	stage('Docker Agent'){
		RunAgent.inside("${jenkinsAgentRunArgs}") {
			sshagent (credentials: ['nomad-ssh-agent']) {
					    sh "ansible-playbook nomad-job.yml"
						}
				}
		}

	stage('Clear'){
		deleteDir()
		}
}