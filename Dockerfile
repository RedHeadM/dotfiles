#FROM haskell:8.2.1
#FROM haskell:latest
FROM ubuntu:latest

USER root
WORKDIR /root

run apt-get update && \
  apt-get -y upgrade

# make and xz-utils are required to build ghc 7.10.3, which is required by
# zsh-git-prompt
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y \
  curl \
  make \
  wget \
  #shopt \
  grep \
  xz-utils \
  zsh \
  gawk \
  tmux \
  xsel \
  neovim \ 
  libevent-dev libncurses-dev build-essential libssl-dev libffi-dev bison byacc\
  silversearcher-ag ctags \
  python3 python3-dev python3-pip \
  libtool autoconf automake cmake libncurses5-dev g++ pkg-config unzip git libtool-bin gettext  
# xsel for tmux-yank, copy to clipboard
# awk is zplug:  zsh plugin manger 
# byacc bision for tmux form src
RUN snap install ripgrep --classic

#ENV LD_LIBRARY_PATH=/usr/local/lib
# Need to set these to successfully install oh-my-zsh
#ENV TERM=xterm
ENV SHELL=/bin/bash
#RUN ldconfig
# Install oh-my-zsh
#RUN \
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#ADD ./install.sh .
COPY . ./dotfiles
RUN bash dotfiles/install.sh
RUN bash dotfiles/deploy

# Make ZSH the default shell for the current user in the container
# To check that the shell was indeed added: `chsh -l` and you should see it in the  list.
#RUN chsh -s ~/.zshrc

#RUN /bin/zsh ~/.zshrc
ENTRYPOINT ["/bin/zsh","-i","-c","tmux"] 
#ENTRYPOINT ["/bin/zsh"] 
#ENTRYPOINT ["tmux"] 
#ENTRYPOINT ["tmux"] 
#ENTRYPOINT ["tmux"]
