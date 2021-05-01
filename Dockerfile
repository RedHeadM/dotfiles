#FROM haskell:8.2.1
#FROM haskell:latest
FROM ubuntu:latest

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

#ENV LD_LIBRARY_PATH=/usr/local/lib
# Need to set these to successfully install oh-my-zsh
ENV TERM=xterm
ENV SHELL=/bin/bash
#RUN ldconfig
# Install oh-my-zsh
#RUN \
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#ADD ./install.sh .
COPY . ./dotfiles
RUN bash dotfiles/install.sh
RUN bash dotfiles/deploy

ENTRYPOINT ["zsh"]
#ENTRYPOINT ["bash"]
