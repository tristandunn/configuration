CWD=$(shell pwd)

install:
	make $(HOME)/.aliases
	make $(HOME)/.claude/settings.json
	make $(HOME)/.config/kitty/kitty.conf
	make $(HOME)/.config/nvim/init.lua
	make $(HOME)/.gemrc
	make $(HOME)/.gitconfig
	make $(HOME)/.hushlogin
	make $(HOME)/.inputrc
	make $(HOME)/.rgignore
	make $(HOME)/.rspec
	make $(HOME)/.tmux.conf
	make $(HOME)/.tool-versions
	make $(HOME)/.zlogin
	make $(HOME)/.zshenv
	make $(HOME)/.zshrc
	make homebrew
	make homebrew-bundle

homebrew:
	-@which brew > /dev/null || \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

homebrew-bundle:
	brew bundle -v

uninstall:
	-test -L $(HOME)/.aliases && rm -fv $(HOME)/.aliases
	-test -L $(HOME)/.claude/settings.json && rm -fv $(HOME)/.claude/settings.json
	-test -L $(HOME)/.config/kitty/kitty.conf && rm -fv $(HOME)/.config/kitty/kitty.conf
	-test -L $(HOME)/.config/nvim/init.lua && rm -fv $(HOME)/.config/nvim
	-test -L $(HOME)/.gemrc && rm -fv $(HOME)/.gemrc
	-test -L $(HOME)/.gitconfig && rm -fv $(HOME)/.gitconfig
	-test -L $(HOME)/.hushlogin && rm -fv $(HOME)/.hushlogin
	-test -L $(HOME)/.inputrc && rm -fv $(HOME)/.inputrc
	-test -L $(HOME)/.rgignore && rm -fv $(HOME)/.rgignore
	-test -L $(HOME)/.rspec && rm -fv $(HOME)/.rspec
	-test -L $(HOME)/.tmux.conf && rm -fv $(HOME)/.tmux.conf
	-test -L $(HOME)/.tool-versions && rm -fv $(HOME)/.tool-versions
	-test -L $(HOME)/.zlogin && rm -fv $(HOME)/.zlogin
	-test -L $(HOME)/.zshenv && rm -fv $(HOME)/.zshenv
	-test -L $(HOME)/.zshrc && rm -fv $(HOME)/.zshrc

$(HOME)/.aliases:
	ln -sv $(CWD)/aliases $(HOME)/.aliases

$(HOME)/.claude/settings.json:
	mkdir -p $(HOME)/.claude
	ln -sv $(CWD)/claude/settings.json $(HOME)/.claude/settings.json

$(HOME)/.config/kitty/kitty.conf:
	mkdir -p $(HOME)/.config/kitty
	ln -sv $(CWD)/kitty.conf $(HOME)/.config/kitty/kitty.conf

$(HOME)/.config/nvim/init.lua:
	mkdir -p $(HOME)/.config/nvim/colors
	mkdir -p $(HOME)/.config/nvim/lua
	ln -sv $(CWD)/nvim/init.lua $(HOME)/.config/nvim/init.lua
	ln -sv $(CWD)/nvim/colors/ir_black.vim $(HOME)/.config/nvim/colors/ir_black.vim
	ln -sv $(CWD)/nvim/lsp $(HOME)/.config/nvim/lsp
	ln -sv $(CWD)/nvim/plug-ins $(HOME)/.config/nvim/lua/plug-ins
	ln -sv $(CWD)/nvim/settings $(HOME)/.config/nvim/lua/settings

$(HOME)/.gemrc:
	ln -sv $(CWD)/gemrc $(HOME)/.gemrc

$(HOME)/.gitconfig:
	ln -sv $(CWD)/gitconfig $(HOME)/.gitconfig

$(HOME)/.hushlogin:
	ln -sv $(CWD)/hushlogin $(HOME)/.hushlogin

$(HOME)/.inputrc:
	ln -sv $(CWD)/inputrc $(HOME)/.inputrc

$(HOME)/.rgignore:
	ln -sv $(CWD)/rgignore $(HOME)/.rgignore

$(HOME)/.rspec:
	ln -sv $(CWD)/rspec $(HOME)/.rspec

$(HOME)/.tmux.conf:
	ln -sv $(CWD)/tmux.conf $(HOME)/.tmux.conf

$(HOME)/.tool-versions:
	ln -sv $(CWD)/tool-versions $(HOME)/.tool-versions

$(HOME)/.zlogin:
	ln -sv $(CWD)/zlogin $(HOME)/.zlogin

$(HOME)/.zshenv:
	ln -sv $(CWD)/zshenv $(HOME)/.zshenv

$(HOME)/.zshrc:
	ln -sv $(CWD)/zshrc $(HOME)/.zshrc
