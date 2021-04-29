write_pathmunge () {
    # only append to path if not set
    # 1 path to bin 
    # 2 file
    #echo "[ \":\$PATH:\" != *":$1:"* ]" "&& export PATH="\$PATH:$1"" >> $2
    echo "if ! echo \$PATH | /bin/egrep -q \"(^|:)$1($|:)\" ; then" >> $2
          echo "    export PATH=\$PATH:"$1 >> $2
    echo fi >> $2
}

# creat ~/.zshrc if not exitsts
if [ ! -d "~/.zshrc" ]; then
	touch ~/.zshrc
fi
# creat ~/.zshrc if not exitsts
if [ ! -d "~/.bashrc" ]; then
	touch ~/.bashrc
fi

source ~/.bashrc

# 0. oh-my-zsh shell 
# requires zsh to be installed
echo "[step 10] zsh"
export ZSH=$HOME/.oh-my-zsh
if [ ! -d $ZSH ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# 1. install neovim

echo "[step 1] installing neovim"

if command -v nvim > /dev/null; then
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
    write_pathmunge "${NVIM_HOME}/bin" ~/.bashrc
    write_pathmunge "${NVIM_HOME}/bin" ~/.zshrc
	#source ~/.bashrc
	source $HOME/.bashrc
    echo "path ${PATH}"
fi


# 2. install node.js

echo "[step 2] installing and node.js"
if command -v node > /dev/null; then
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
    write_pathmunge "${NVM_DIR}/versions/node/v${NODE_VERSION}/bin" ~/.bashrc
	source $HOME/.bashrc

	echo "export NODE_PATH=\"\${NVM_DIR}/v{$NODE_VERSION}/lib/node_modules\"" >> $HOME/.zshrc
    write_pathmunge "${NVM_DIR}/versions/node/v${NODE_VERSION}/bin" ~/.zshrc
    # auto added to bashrc
    echo "export NVM_DIR=$NVM_DIR" >> ~/.zshrc
    echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm" >> ~/.zshrc
    echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" >> ~/.zshrc

fi

# 3. install node.js packages via npm

echo "[step 3] installing node.js packages: neovim and yarn"
npm install -g neovim yarn

# 4. install Plug
echo "[step 4] installing plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# 5. install plugins via Plug
echo "[step 5] installing plugins"
if [[ ! -d $HOME/.config/nvim ]]; then
	mkdir -p $HOME/.config/nvim
fi
if [[ ! -f $HOME/.config/nvim/init.vim ]]; then
	wget https://gist.githubusercontent.com/wsntxxn/5bbe7856a472985d82f62e1b0895ce60/raw/fc7db25e1af2b9dae8969021c52c21ce06be3bb5/init.vim -P $HOME/.config/nvim/
fi
nvim +'PlugInstall --sync' +qa

# 6. install packages via pip
echo "[step 6] installing python packages: neovim and notedown"
#pip install --user neovim notedown
# TODO https://www.hassanaskary.com/vim/conda/python/2020/04/27/how-to-setup-neovim-with-python-provider-using-conda.html
pip3 install --user neovim notedown pynvim pep8 flake8 pyflakes pylint isort
pip2 install --user neovim notedown pynvim pep8 flake8 pyflakes pylint isort

# 7. postprocessing for semshi
echo "[step 7] post processing step for installing semshi"
nvim +'UpdateRemotePlugins' +qa 

# 8. install coc plugins
echo "[step 8] installing coc plugins"
nvim +'CocInstall coc-python coc-json coc-jedi'

# 9. install fzf 
echo "[step 9] FZF"
# Another option is to use fzf extension
#sudo apt remove -y fzf
export FZF=$HOME/.fzf
if [ ! -d $FZF ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
    $FZF/install --all --no-fish
	echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $FZF
    #[ -f $FZF ] && source $FZF
	source $HOME/.bashrc
fi


echo "shell ${SHELL}"
echo "path ${PATH}"
echo "[step END] print versions"
echo $(zsh --version)
echo "nvm "$(nvm --version)
echo $(nvim --version)
echo $(fzf --version)
echo $(tmux -V)


echo "Finish installing neovim and coc.nvim!"
