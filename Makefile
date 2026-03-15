.PHONY: scripts ghostty hypr waybar

scripts:
	if [ -e "$(HOME)/._profile" ]; then rm "$(HOME)/._profile"; fi
	ln -s -t "$(HOME)/" "$(HOME)/dotfiles/scripts/scripts/._profile"
	echo "" >> "$(HOME)/.profile" && echo 'source $${HOME}/._profile' >> "$(HOME)/.profile"

ghostty:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(HOME)/dotfiles/ghostty/config $(HOME)/.config/ghostty/config
	ln -sf $(HOME)/dotfiles/ghostty/themes $(HOME)/.config/ghostty/themes

hypr:
	mkdir -p $(HOME)/.config/hypr/scripts
	ln -sf $(HOME)/dotfiles/hypr/hyprland.conf $(HOME)/.config/hypr/hyprland.conf
	ln -sf $(HOME)/dotfiles/hypr/scripts/xdg-portal-init.sh $(HOME)/.config/hypr/scripts/xdg-portal-init.sh
	ln -sf $(HOME)/dotfiles/hypr/scripts/hypr-window-switcher.sh $(HOME)/.config/hypr/scripts/hypr-window-switcher.sh

waybar:
	mkdir -p $(HOME)/.config/waybar
	ln -sf $(HOME)/dotfiles/waybar/config.jsonc $(HOME)/.config/waybar/config.jsonc
	ln -sf $(HOME)/dotfiles/waybar/style.css $(HOME)/.config/waybar/style.css

