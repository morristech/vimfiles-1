lockfile := ./bin/restore
vim := nvim
pwd := $(shell pwd -LP)

default: install

# Install into home directory
link: link-vim link-neovim
	@if [ ! -d ~/.vim/vendor ]; then \
		echo "\n\033[32;1m→ NOTE:\033[0m run ':PlugInstall' in Vim to install plugins."; \
		echo "  (alternatively, use 'make install')"; \
	fi

link-vim:
	ln -nfs "${pwd}" ~/.vim
	ln -nfs "${pwd}/vimrc.vm" ~/.vimrc

link-neovim:
	ln -nfs "${pwd}" ~/.nvim
	ln -nfs "${pwd}/vimrc.vm" ~/.nvimrc

# Installs plugins, produces lockfile
install:
	$(vim) +PlugInstall +PlugClean +"PlugSnapshot ${lockfile}" +qa

# Updates plugins, vim-plug, and show changes
upgrade:
	$(vim) +PlugUpdate +PlugUpgrade +PlugClean +"PlugSnapshot ${lockfile}" +PlugDiff

# Install from lockfile
restore:
	${lockfile}

.PHONY: install link upgrade restore default link-vim link-neovim
