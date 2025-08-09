# Start from the official Jenkins inbound-agent image
FROM jenkins/inbound-agent

# Switch to the root user to install packages
USER root

# Install Docker CLI and Git
RUN apt-get update && apt-get install -y docker.io git ansible

# Switch back to the jenkins user
USER jenkins
