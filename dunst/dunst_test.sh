#!/bin/env bash

if [[ $DUNST_BODY =~ teams.microsoft.com ]]; then
  aplay ~/dotfiles/dunst/coin.wav
  exit 0
fi
aplay ~/dotfiles/dunst/notificaton1.wav
