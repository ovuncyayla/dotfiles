#!/bin/env bash

# canberra-gtk-play -i service-login

if [[ $DUNST_BODY =~ teams.microsoft.com ]]; then
  gsound-play -i service-logout
  exit 0
fi

gsound-play -i service-login
