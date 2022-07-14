FROM ubuntu:focal AS base
# WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN apt-get install wget -y
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g npm@8.3.0
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y sudo
RUN echo 'root:root' | chpasswd
RUN mkdir /ANSIBLE_FILES
COPY . /ANSIBLE_FILES
RUN ansible-playbook /ANSIBLE_FILES/local.yml
# CMD ["zsh"]
