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

			sshagent (credentials: ['nomad-ssh-agent']) {			
				sh 'ansible -i ./hosts.txt -m ping all'
			}
		}
	}

	finally {
		stage('Cleanup') {
			deleteDir()
		}	
	}
}
