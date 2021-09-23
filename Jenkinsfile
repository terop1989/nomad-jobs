node('master'){
    
        stage('Checkout SCM'){
                checkout scm
        }

        NomadHostName = 'nomad01.local.com'
        NomadHostIP = '192.168.0.112'
        NomadJobFile = 'nginx-alpine.hcl'

	jenkinsAgentDockerfileName = 'ansible-agent.dockerfile'
	jenkinsAgentBuildName = 'ansible-agent:latest'
	jenkinsAgentBuildArgs = ''
	jenkinsAgentRunArgs = " -u 0:0 --add-host=\"${NomadHostName}:${NomadHostIP}\""
	def AnsibleAgent = docker.build("${jenkinsAgentBuildName}", "${jenkinsAgentBuildArgs} -f ${jenkinsAgentDockerfileName} .")
        
	stage('Docker Agent'){
		AnsibleAgent.inside("${jenkinsAgentRunArgs}") {
			sshagent (credentials: ['nomad-ssh-agent']) {
					    sh """
					        mkdir /root/.ssh
					        ssh-keyscan -t rsa "${NomadHostName}" >> ~/.ssh/known_hosts
					        scp ./"${NomadJobFile}" ansible@"${NomadHostName}":/home/ansible
					        ssh ansible@"${NomadHostName}" 'nomad job run ./"${NomadJobFile}"'
					        ssh ansible@"${NomadHostName}" 'rm -f ./"${NomadJobFile}"'
					        """
			}
                }
        }
    
	stage('Clear'){
		deleteDir()
        }
    
}
