run:
	. ./init.sh

config:
	. ./config_apps.sh

install-collections:
	ansible-galaxy collection install -r requirements.yml -p collections

lint-install:
	pipx install ansible-lint

lint:
	ansible-lint
