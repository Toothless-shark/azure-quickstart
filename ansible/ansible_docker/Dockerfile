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
