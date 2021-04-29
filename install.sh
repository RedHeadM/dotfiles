

# creat ~/.zshrc if not exitsts
if [ ! -d "~/.zshrc" ]; then
	touch ~/.zshrc
fi
# creat ~/.zshrc if not exitsts
if [ ! -d "~/.bashrc" ]; then
	touch ~/.bashrc
fi

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

if command -v nvim > /dev/null; then
	echo "nvim has been installed"
else
	NVIM_HOME="$HOME/.modules/neovim" # /usr/local/nvim
	printf "Neovim will be installed into this location:\\n"
	printf "%s\\n" "${NVIM_HOME}"

	git clone https://github.com/neovim/neovim.git ${NVIM_HOME} && \
	cd ${NVIM_HOME} && \
	make && make install && \
	cd ../ && rm -rf ${NVIM_HOME}
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
	echo "export PATH=\"\$PATH:${NVM_DIR}/versions/node/v$NODE_VERSION/bin\"" >> $HOME/.bashrc
	source $HOME/.bashrc

	echo "export NODE_PATH=\"\${NVM_DIR}/v{$NODE_VERSION}/lib/node_modules\"" >> $HOME/.zshrc
	echo "export PATH=\"\$PATH:${NVM_DIR}/versions/node/v$NODE_VERSION/bin\"" >> $HOME/.zshrc

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
	echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $HOME/.zshrc
    [ -f $FZF ] && source $FZF
fi


echo "[step END] print versions"
echo $(zsh --version)
echo "nvm "$(command -v nvm)
echo $(nvim --version)
echo $(fzf --version)
echo $(tmux -V)


echo "Finish installing neovim and coc.nvim!"
