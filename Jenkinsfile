node('master') {

	try {

		stage('Checkout SCM') {
			checkout scm
		}

		jenkinsAgentDockerfileName = 'ansible-agent.dockerfile'
		jenkinsAgentBuildName = 'ansible-agent/ansible:latest'
		jenkinsAgentBuildArgs = ''

		def AnsibleAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
		AnsibleAgent.inside() {
			
			sh 'uname -a'

		}
	}

	finally {
		stage('Cleanup') {
			deleteDir()
		}	
	}
}
