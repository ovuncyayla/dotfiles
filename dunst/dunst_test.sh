#!/bin/env bash

# canberra-gtk-play -i service-login

if [[ $DUNST_BODY =~ teams.microsoft.com ]]; then
  aplay -f ~/dotfiles/dunst/coin.wav
  exit 0
fi
aplay -f ~/dotfiles/dunst/notificaton1.wav
