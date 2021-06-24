# Pull base image.
FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]
USER root

RUN \
# Update
apt-get update -y && \
# Install Unzip
apt-get install unzip -y && \
# need wget
apt-get install wget -y && \
# vim
apt-get install vim -y

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_linux_amd64.zip

# Unzip
RUN unzip terraform_0.14.9_linux_amd64.zip

# Move to local bin
RUN mv terraform /usr/local/bin/
# Check that it's installed
RUN terraform --version 

################################
# Install Go
################################

# Download and unzip
RUN wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz

# Untar
RUN tar -xvf go1.16.2.linux-amd64.tar.gz -C /usr/local
ENV PATH="/usr/local/go/bin:${PATH}"

# Check install
RUN go version

################################
# Install python
################################

RUN apt-get install -y python3-pip
#RUN ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version

################################
# Install checkob
################################

# install
RUN pip3 install checkov

# Check install
RUN checkov --version

################################
# Install AWS CLI
################################

# Install
RUN pip3 --no-cache-dir install --upgrade awscli

# Check install
RUN aws --version
