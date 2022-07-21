# ansible
## Installation

decrypt key and ask for sudo

> ansible-playbook local.yml --tags "ssh" --ask-vault-pass --ask-become-pass

or install everything:

> ansible-playbook local.yml --ask-vault-pass --ask-become-pass
