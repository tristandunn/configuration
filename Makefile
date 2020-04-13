CWD=$(shell pwd)

install:
	make $(HOME)/.agignore
	make $(HOME)/.aliases
	make $(HOME)/.config/kitty/kitty.conf
	make $(HOME)/.gemrc
	make $(HOME)/.gitconfig
	make $(HOME)/.gitignore
	make $(HOME)/.hushlogin
	make $(HOME)/.inputrc
	make $(HOME)/.psqlrc
	make $(HOME)/.rspec
	make $(HOME)/.vim/autoload
	make $(HOME)/.vim/colors
	make $(HOME)/.vim/spell
	make $(HOME)/.vimrc
	make $(HOME)/.zlogin
	make $(HOME)/.zshrc
	make homebrew
	make homebrew-bundle

homebrew:
	-@which brew > /dev/null || \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

homebrew-bundle:
	brew bundle -v

uninstall:
	-test -L $(HOME)/.agignore && rm -fv $(HOME)/.agignore
	-test -L $(HOME)/.aliases && rm -fv $(HOME)/.aliases
	-test -L $(HOME)/.config/kitty/kitty.conf && rm -fv $(HOME)/.config/kitty/kitty.conf
	-test -L $(HOME)/.gemrc && rm -fv $(HOME)/.gemrc
	-test -L $(HOME)/.gitconfig && rm -fv $(HOME)/.gitconfig
	-test -L $(HOME)/.gitignore && rm -fv $(HOME)/.gitignore
	-test -L $(HOME)/.hushlogin && rm -fv $(HOME)/.hushlogin
	-test -L $(HOME)/.inputrc && rm -fv $(HOME)/.inputrc
	-test -L $(HOME)/.psqlrc && rm -fv $(HOME)/.psqlrc
	-test -L $(HOME)/.rspec && rm -fv $(HOME)/.rspec
	-test -L $(HOME)/.vim/autoload/plug.vim && rm -fvr $(HOME)/.vim/autoload/plug.vim
	-test -L $(HOME)/.vim/colors/ir_black.vim && rm -fvr $(HOME)/.vim/colors/ir_black.vim
	-test -L $(HOME)/.vim/spell/en.utf-8.add && rm -fvr $(HOME)/.vim/spell/en.utf-8.add
	-test -L $(HOME)/.vim/spell/en.utf-8.add.spl && rm -fvr $(HOME)/.vim/spell/en.utf-8.add.spl
	-test -L $(HOME)/.vimrc && rm -fv $(HOME)/.vimrc
	-test -L $(HOME)/.zlogin && rm -fv $(HOME)/.zlogin
	-test -L $(HOME)/.zshrc && rm -fv $(HOME)/.zshrc

$(HOME)/.agignore:
	ln -sv $(CWD)/agignore $(HOME)/.agignore

$(HOME)/.aliases:
	ln -sv $(CWD)/aliases $(HOME)/.aliases

$(HOME)/.config/kitty/kitty.conf:
	mkdir -p $(HOME)/.config/kitty && \
		ln -sv $(CWD)/kitty.conf $(HOME)/.config/kitty/kitty.conf

$(HOME)/.gemrc:
	ln -sv $(CWD)/gemrc $(HOME)/.gemrc

$(HOME)/.gitconfig:
	ln -sv $(CWD)/gitconfig $(HOME)/.gitconfig

$(HOME)/.gitignore:
	ln -sv $(CWD)/gitignore $(HOME)/.gitignore

$(HOME)/.hushlogin:
	ln -sv $(CWD)/hushlogin $(HOME)/.hushlogin

$(HOME)/.inputrc:
	ln -sv $(CWD)/inputrc $(HOME)/.inputrc

$(HOME)/.psqlrc:
	ln -sv $(CWD)/psqlrc $(HOME)/.psqlrc

$(HOME)/.rspec:
	ln -sv $(CWD)/rspec $(HOME)/.rspec

$(HOME)/.vim/autoload:
	mkdir -p $(HOME)/.vim/autoload && \
		ln -sv $(CWD)/vim/autoload/plug.vim $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vim/colors:
	mkdir -p $(HOME)/.vim/colors && \
		ln -sv $(CWD)/vim/colors/ir_black.vim $(HOME)/.vim/colors/ir_black.vim

$(HOME)/.vim/spell:
	mkdir -p $(HOME)/.vim/spell && \
		ln -sv $(CWD)/vim/spell/en.utf-8.add $(HOME)/.vim/spell/en.utf-8.add && \
		ln -sv $(CWD)/vim/spell/en.utf-8.add.spl $(HOME)/.vim/spell/en.utf-8.add.spl

$(HOME)/.vimrc:
	ln -sv $(CWD)/vimrc $(HOME)/.vimrc

$(HOME)/.zlogin:
	ln -sv $(CWD)/zlogin $(HOME)/.zlogin

$(HOME)/.zshrc:
	ln -sv $(CWD)/zshrc $(HOME)/.zshrc
