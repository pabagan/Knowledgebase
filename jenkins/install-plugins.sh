docker run --name myjenkins -p 8080:8080 -p 50001:50001 --env JENKINS_SLAVE_AGENT_PORT=50001 jenkins/jenkins:lts