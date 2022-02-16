node('master'){

	stage('Checkout SCM'){
		checkout scm
	}

	jenkinsAgentDockerfileName = 'run-agent.dockerfile'
	jenkinsAgentBuildName = 'run-agent:latest'
	jenkinsAgentBuildArgs = ''
	jenkinsAgentRunArgs = " -u 0:0"
	def RunAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
	NomadHostIP = '192.168.0.112'

	stage('Docker Agent'){

		RunAgent.inside("${jenkinsAgentRunArgs}") {

						sh "ansible-playbook nomad-job.yml -e 'nomad_address=${NomadHostIP}'"
						}

		}

	stage('Clear'){
		deleteDir()
		}
}