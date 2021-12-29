FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS prime
ARG TAGS
WORKDIR /home/piet

FROM prime
COPY . .
# RUN ansible-playbook fem.yml
RUN cd /root && echo "alias nvim='/home/piet/./nvim.appimage --appimage-extract-and-run'" >> .bashrc && cd /home/piet
RUN cd /root && echo "alias nvim='/home/piet/./nvim.appimage --appimage-extract-and-run'" >> .zshrc && cd /home/piet
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

