FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
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
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g npm@8.3.0

FROM base AS prime
ARG TAGS
WORKDIR /home/piet
# RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN curl -fLo "${XDG_DATA_HOME:-/home/piet/neovim}"/nvim.appimage --create-dirs https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x neovim/nvim.appimage
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN apt-get install -y python3-venv 
RUN apt-get install -y python3-pip
RUN pip install neovim
##LangServers for neovim LSP
RUN npm install -g typescript typescript-language-server
RUN npm install -g diagnostic-languageserver
RUN npm install -g neovim
##ZSH
# RUN apt-get install zsh -y
# RUN chsh -s 'which zsh'
# RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

FROM prime
# COPY . .
RUN rm -rf /root/.config
RUN mkdir /root/.config
RUN git clone https://github.com/pietow/neovim-init.vim.git /root/.config/nvim
RUN cd ~/.config/nvim && git checkout cleanPlusPlugins && cd /home/piet
RUN cd /root && echo "alias nvim='/home/piet/neovim/./nvim.appimage --appimage-extract-and-run'" >> .bashrc && cd /home/piet
RUN cd /root && echo "alias nvim='/home/piet/neovim/./nvim.appimage --appimage-extract-and-run'" >> .zshrc && cd /home/piet
RUN neovim/./nvim.appimage --appimage-extract-and-run "+silent! PlugInstall!" +qall!
RUN cd ~/.config/nvim && git checkout LSP-vim && cd /home/piet
RUN apt-get install xclip
WORKDIR /home/piet/workspace
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

