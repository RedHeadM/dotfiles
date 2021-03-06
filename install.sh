write_pathmunge () {
    # only append to path if not set
    # 1 path to bin 
    # 2 file
    # 2 expend path "before" or "after"

    # set default place: after
    if [ -z "$3" ]
    then
        place=$3
    else
        place="after"
    fi

    # check if set in file 
	if  !  grep -Fxq $1 $2 ; then
        # write if statement which check if set in PATH
        echo "if ! echo \$PATH | /bin/egrep -q \"(^|:)$1($|:)\" ; then" >> $2
            if [ "$place" = "after" ] ; then
                echo "    export PATH=\$PATH:"$1 >> $2
            else
                echo "    export PATH=$1:\$PATH:" >> $2
            fi
        echo fi >> $2
    fi
    # set PATH for skript if not set before
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ "$place" = "after" ] ; then
            PATH=$PATH:$1
         else
            PATH=$1:$PATH
        fi
    fi
}

check_min_version() { 
    # (1) version was strint
    # (2) version
    # useage:   
    #   if  ! $(check_min_version "$(tmux -V)" 2.9) ; then
    #   if   $(! _exists tmux)   || ! $(check_min_version "$(tmux -V)" 2.4) ; then
    echo [ "$(python -c "print(float(re.sub('[^A-Za-z]+', '','$(gettext $1)').split()[-1])>=float($2))")" == "True" ]
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
    # requires cmake, libtool-bin
    # neovim form source with no root
	NVIM_HOME="$HOME/.modules/neovim" # /usr/local/nvim
	NVIM_TMP="$HOME/.modules/neovim_tmp" # /usr/local/nvim

    # creat ~/.zshrc if not exitsts
    if [ -d "$NVIM_HOME" ]; then
        rm -rf  $NVIM_HOME
    fi
    if [ -d "$NVIM_TMP" ]; then
        rm -rf  $NVIM_TMP
    fi
	printf "Neovim will be installed into this location:\\n"
	printf "%s\\n" "${NVIM_HOME}"

	git clone https://github.com/neovim/neovim.git ${NVIM_TMP} && \
	cd ${NVIM_TMP} && \
    git checkout d9dd30a955073d602741481d48e1c56d1fcae420  && \ 
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

    # auto added to bashrc
    echo "export NVM_DIR=$NVM_DIR" >> ~/.zshrc
    echo "export NODE_VERSION=$NODE_VERSION" >> ~/.zshrc
	echo "export NODE_PATH=\"\${NVM_DIR}/v\${NODE_VERSION}/lib/node_modules\"" >> $HOME/.zshrc
    write_pathmunge "\${NVM_DIR}/versions/node/v\${NODE_VERSION}/bin/" ~/.zshrc
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
#echo "[step 9] FZF"
# moved to zsh plugin manger zink
# Another option is to use fzf extension
#sudo apt remove -y fzf
#export FZF=$HOME/.fzf
#if ! _exists fzf; then
    #git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
    #$FZF/install --all --no-fish
	##echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $FZF
#fi

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


#if ! _exists tmux; then
if $(! _exists tmux) || ! $(check_min_version "$(tmux -V)" 2.8) ; then

    # requires byacc, automake to bo installed
    export tmux_dir="$HOME/.modules/tmux"                                 
    echo "tmux will be installed to $tmux_dir"
    git clone https://github.com/tmux/tmux.git $tmux_dir && \
    cd $tmux_dir && \
    sh autogen.sh && \
    ./configure && make
    #cd $fpp_dir/debian && \
    #./package.sh && \
    #ls ../fpp_0.7.2_noarch.deb && \
    write_pathmunge $tmux_dir ~/.zshrc before
    write_pathmunge $tmux_dir ~/.bashrc before
fi

#if ! _exists conda; then
	#CONDA_DIR=~/.modules/conda 
	#echo "conda will be installed to $CONDA_DIR"
	#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
	#bash conda.sh -b -p $CONDA_DIR
	#rm -f conda.sh
	#$CONDA_DIR/bin/conda init bash
	#$CONDA_DIR/bin/conda init zshrc
	#write_pathmunge $CONDA_DIR/bin ~/.bashrc
	#write_pathmunge $CONDA_DIR/bin ~/.zshrc
	#conda init bash
	#conda init zsh
#fi

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
