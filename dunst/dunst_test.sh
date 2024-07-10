#!/bin/env bash

# canberra-gtk-play -i service-login

if [[ $DUNST_BODY =~ teams.microsoft.com ]]; then
  gsound-play -f ~/dotfiles/dunst/coin.wav
  exit 0
fi
gsound-play -f ~/dotfiles/dunst/notificaton1.wav
