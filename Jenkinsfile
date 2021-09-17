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

			stage('Ansible') {
				sshagent (credentials: ['nomad-ssh-agent']) {			
					sh "/usr/local/bin/ansible -i ./hosts.txt -m ping all -v"
				}
			}
		}
	}

	finally {
		stage('Cleanup') {
			deleteDir()
		}	
	}
}
