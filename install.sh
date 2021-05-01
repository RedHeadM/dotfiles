write_pathmunge () {
    # only append to path if not set
    # 1 path to bin 
    # 2 file
    #echo "[ \":\$PATH:\" != *":$1:"* ]" "&& export PATH="\$PATH:$1"" >> $2
    echo "if ! echo \$PATH | /bin/egrep -q \"(^|:)$1($|:)\" ; then" >> $2
          echo "    export PATH=\$PATH:"$1 >> $2
    echo fi >> $2
    # add for skript
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
          PATH=$PATH:$1
    fi
}

_exists () {
    type "$1" &> /dev/null ;
}

# creat ~/.zshrc if not exitsts
if [ ! -d "~/.zshrc" ]; then
	touch ~/.zshrc
fi
# creat ~/.zshrc if not exitsts
if [ ! -d "~/.bashrc" ]; then
	touch ~/.bashrc
fi


# 0. oh-my-zsh shell 
# requires zsh to be installed
echo "[step 10] zsh"
export ZSH=$HOME/.oh-my-zsh
if [ ! -d $ZSH ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# 1. install neovim

echo "[step 1] installing neovim"

if _exists nvim; then
	echo "nvim has been installed"
else
    # neovim form source with no root
	NVIM_HOME="$HOME/.modules/neovim" # /usr/local/nvim
	NVIM_TMP="$HOME/.modules/neovim_tmp" # /usr/local/nvim
	printf "Neovim will be installed into this location:\\n"
	printf "%s\\n" "${NVIM_HOME}"

	git clone https://github.com/neovim/neovim.git ${NVIM_TMP} && \
	cd ${NVIM_TMP} && \
    make CMAKE_INSTALL_PREFIX=${NVIM_HOME} &&\
	make && make install && \
	cd ../ && rm -rf ${NVIM_TMP}
    write_pathmunge "${NVIM_HOME}/bin/" ~/.bashrc
    write_pathmunge "${NVIM_HOME}/bin/" ~/.zshrc
	#source ~/.bashrc
	source $HOME/.bashrc
fi


# 2. install node.js

echo "[step 2] installing and node.js"
if _exists nvm; then
	echo "node has been installed"
else
	# nvm environment variables
	export NVM_DIR="$HOME/.modules/node"
	#export NODE_VERSION=15.14.0
	export NODE_VERSION=14.15.0

	printf "Node.js will be installed into this location:\\n"
	printf "%s\\n" "${NVM_DIR}"

	if [[ ! -d ${NVM_DIR} ]]; then
		mkdir -p ${NVM_DIR}
	fi
	# install nvm
	# https://github.com/creationix/nvm#install-script
	# https://github.com/nvm-sh/nvm
	curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

	# install node and npm
	source $NVM_DIR/nvm.sh \
			&& nvm install $NODE_VERSION \
				&& nvm alias default $NODE_VERSION \
					&& nvm use default

	# add node and npm to path so the commands are available
    echo "export NODE_PATH=\"\${NVM_DIR}/v{$NODE_VERSION}/lib/node_modules\"" >> $HOME/.bashrc
    write_pathmunge "${NVM_DIR}/versions/node/v${NODE_VERSION}/bin/" ~/.bashrc
	source $HOME/.bashrc

	echo "export NODE_PATH=\"\${NVM_DIR}/v{$NODE_VERSION}/lib/node_modules\"" >> $HOME/.zshrc
    write_pathmunge "${NVM_DIR}/versions/node/v${NODE_VERSION}/bin/" ~/.zshrc
    # auto added to bashrc
    echo "export NVM_DIR=$NVM_DIR" >> ~/.zshrc
    echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm" >> ~/.zshrc
    echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" >> ~/.zshrc

    # set for local installation
    #npm set prefix ~/.npm
    write_pathmunge "./node_modules/.bin" ~/.bashrc
    write_pathmunge "$HOME/.npm/bin" ~/.bashrc
    write_pathmunge "$HOME/.npm/bin" ~/.zshrc
    write_pathmunge "./node_modules/.bin" ~/.zshrc
	source $HOME/.bashrc
fi

# 3. install node.js packages via npm

# 9. install fzf 
echo "[step 9] FZF"
# Another option is to use fzf extension
#sudo apt remove -y fzf
export FZF=$HOME/.fzf
if ! _exists fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
    $FZF/install --all --no-fish
	#echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $FZF
fi

# PathPicker 
if ! _exists fpp; then
	export FPP_DIR="$HOME/.modules/fpp"                                 
	echo "fpp will be installed to $FPP_DIR"
	git clone https://github.com/facebook/PathPicker.git $FPP_DIR
	#cd $FPP_DIR/debian && \
	#./package.sh && \
	#ls ../fpp_0.7.2_noarch.deb && \
	write_pathmunge $FPP_DIR ~/.zshrc
	write_pathmunge $FPP_DIR ~/.bashrc
fi

if ! _exists tmux; then
	export tmux_dir="$home/.modules/tmux"                                 
	echo "tmux will be installed to $tmux_dir"
	git clone https://github.com/tmux/tmux.git $tmux_dir && \
	cd $tmux_dir && \
    sh autogen.sh && \
    ./configure && make
	#cd $fpp_dir/debian && \
	#./package.sh && \
	#ls ../fpp_0.7.2_noarch.deb && \
	write_pathmunge $tmux_dir ~/.zshrc
	write_pathmunge $tmux_dir ~/.bashrc
fi

if ! _exists conda; then
	CONDA_DIR=~/.modules/conda 
	echo "conda will be installed to $CONDA_DIR"
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
	bash conda.sh -b -p $CONDA_DIR
	rm -f conda.sh
	$CONDA_DIR/bin/conda init bash
	$CONDA_DIR/bin/conda init zshrc
	write_pathmunge $CONDA_DIR/bin ~/.bashrc
	write_pathmunge $CONDA_DIR/bin ~/.zshrc
	conda init bash
	conda init zsh
fi

echo "shell ${SHELL}"
echo "path ${PATH}"
echo "[step END] print versions"
echo $(zsh --version)
echo "nvm "$(nvm --version)
echo $(nvim --version)
#echo $(fzf --version)
echo $(tmux -V)
echo $(fpp --verion)


echo "Finish installing neovim and coc.nvim!"
