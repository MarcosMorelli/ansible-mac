#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for current session
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    # Apple Silicon Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    # Intel Mac
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Brew Installed"
fi

which -s pipx
if [[ $? != 0 ]] ; then
  brew install pipx
  pipx ensurepath
else
  echo "Pipx Installed"
fi

which -s ansible
if [[ $? != 0 ]] ; then
  pipx install --include-deps ansible
  # Ensure pipx bin directory is in PATH for current session
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "Ansible Installed"
fi

if [ -f ./vault.pass ]; then
    ansible-playbook main.yml --ask-become-pass --vault-password-file ./vault.pass
else
    ansible-playbook main.yml --ask-become-pass --ask-vault-pass
fi 
