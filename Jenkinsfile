node('master') {

	try {

		stage('Checkout SCM') {
			checkout scm
		}

		jenkinsAgentDockerfileName = 'ansible-agent.dockerfile'
		jenkinsAgentBuildName = 'ansible-agent/ansible:latest'
		jenkinsAgentBuildArgs = ''
		jenkinsAgentRunArgs = " -u 0:0 "

		def AnsibleAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
		AnsibleAgent.inside("${jenkinsAgentRunArgs}") {

			stage('Ansible') {
				sshagent (credentials: ['nomad-ssh-agent']) {
					sh "/usr/local/bin/ansible-playbook nomad-job.yml -v"
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
