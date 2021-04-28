#FROM haskell:8.2.1
#FROM haskell:latest
FROM ubuntu:latest

WORKDIR /root

RUN apt-get update && \
  apt-get -y upgrade

# make and xz-utils are required to build ghc 7.10.3, which is required by
# zsh-git-prompt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y \
  curl \
  make \
  wget \
  xz-utils \
  zsh \
  libtool autoconf automake cmake libncurses5-dev g++ pkg-config unzip git libtool-bin gettext
  #install libtool libtool-bin autoconf automake cmake libncurses5-dev g++ gettext
  #python-dev python-pip python3-dev python3-pip
  #python3.8 
  # python3.8-venv python3.8-dev

#ENV LD_LIBRARY_PATH=/usr/local/lib
# Need to set these to successfully install oh-my-zsh
ENV TERM=xterm
ENV SHELL=/bin/bash
#RUN ldconfig
# Install oh-my-zsh
#RUN \
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ADD ./install.sh .
RUN bash install.sh
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
