scripts:
	if [ -e "$(HOME)/._profile" ]; then rm "$(HOME)/._profile"; fi
	ln -s -t "$(HOME)/" "$(HOME)/dotfiles/scripts/scripts/._profile"
	echo "" >> "$(HOME)/.profile" && echo 'source $${HOME}/._profile' >> "$(HOME)/.profile"

