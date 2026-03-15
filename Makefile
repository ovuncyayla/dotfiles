scripts:
	if [ -e "$(HOME)/._profile" ]; then rm "$(HOME)/._profile"; fi
	ln -s -t "$(HOME)/" "$(HOME)/dotfiles/scripts/scripts/._profile"
	echo "" >> "$(HOME)/.profile" && echo 'source $${HOME}/._profile' >> "$(HOME)/.profile"

ghostty:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(HOME)/dotfiles/ghostty/config $(HOME)/.config/ghostty/config
	ln -sf $(HOME)/dotfiles/ghostty/themes $(HOME)/.config/ghostty/themes

