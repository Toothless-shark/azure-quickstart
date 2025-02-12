# Install Ansible
pip install ansible

# Create a customized docker image
## Within a standard ubuntu image, sshd is deactivated
docker pull ubuntu:latest

Dockerfile:

#Build Ubuntu image with base functionality
FROM ubuntu:latest AS ubuntu-base

#Setup the default user.
RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo user
RUN echo 'user:user' | chpasswd
USER user
WORKDIR /home/user

#Build image with Python and SSHD.
FROM ubuntu-base AS ubuntu-with-sshd
USER root

#Install required tools.
RUN apt-get -qq update \
    && apt-get -qq install vim \
    && apt-get -qq install sudo \
    && apt-get -qq install openssh-server \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./id_rsa.pub /home/user/.ssh/authorized_keys


ENTRYPOINT ["/bin/bash", "-c"]
CMD ["service ssh restart && while true; do sleep 1; done"]

# Build your new image 
docker build . -t <image_name>

# Run your container
docker run --name <container_name> -d <image_name>

# Retrieve your container IP address
Simple way: 
docker inspect <container_name_or_id>  | grep IP

Advanced way:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name_or_id>

# Copy the IP addr in inventory.ini and change the ansible_ssh_private_key_file path

# Verify your hosts
ansible-inventory -i inventory.ini --list

# Test the connection to your hosts
ansible myhosts -m ping -i inventory.ini

# Start your playbook
ansible-playbook -i inventory.ini playbook.yaml