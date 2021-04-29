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
  tmux \
  silversearcher-ag ctags \
  libtool autoconf automake cmake libncurses5-dev g++ pkg-config unzip git libtool-bin gettext  

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
RUN bash dotfiles/deploy
RUN bash dotfiles/install.sh
#RUN \
  #git clone https://github.com/olivierverdier/zsh-git-prompt.git && \
  #cd zsh-git-prompt && \
  #stack setup && \
  #stack build && \
  #stack install

#ADD append-to-zshrc.sh .

#RUN \
  #tee -a ~/.zshrc < append-to-zshrc.sh && \
  #rm append-to-zshrc.sh

ENTRYPOINT ["zsh"]
#ENTRYPOINT ["bash"]
