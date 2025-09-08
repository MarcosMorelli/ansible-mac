#!/usr/bin/env bash

if xpath=$( xcode-select --print-path ) &&
  test -d "${xpath}" && test -x "${xpath}" ; then
  echo "Xcode Installed"
else
  xcode-select --install
fi

which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
else
  echo "Ansible Installed"
fi

if [ -f ./vault.pass ]; then
    ansible-playbook main.yml --ask-become-pass --vault-password-file ./vault.pass
else
    ansible-playbook main.yml --ask-become-pass --ask-vault-pass
fi