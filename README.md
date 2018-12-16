# Development Ubuntu Linux Setup

[![Build Status](https://travis-ci.org/markosamuli/linux-machine.svg?branch=master)](https://travis-ci.org/markosamuli/linux-machine)

This is a collection of Ansible roles and tasks to setup a new developer machine on Ubuntu Linux.

This setup has been tested on the Ubuntu 16.04 and 18.04 LTS releases.

## Requirements

- Ubuntu 16.04 LTS or higher
- Git installed

## Install

You can run the installer script that will clone the code from GitHub and run the `setup` script.

```bash
curl -s https://raw.githubusercontent.com/markosamuli/linux-machine/master/install.sh | bash -
```

## Getting Started

Clone this project locally and run the `./setup` script.

```bash
git clone https://github.com/markosamuli/linux-machine
cd linux-machine
./setup
```

## Ansible Roles

The following external Ansible roles are installed and used:


- [markosamuli.aws-tools](https://github.com/markosamuli/ansible-aws-tools)
- [markosamuli.gcloud](https://github.com/markosamuli/ansible-gcloud)
- [markosamuli.golang](https://github.com/markosamuli/ansible-golang)
- [markosamuli.nvm](https://github.com/markosamuli/ansible-nvm)
- [markosamuli.packer](https://github.com/markosamuli/ansible-packer)
- [markosamuli.pyenv](https://github.com/markosamuli/ansible-pyenv)
- [markosamuli.terraform](https://github.com/markosamuli/ansible-terraform)
- [markosamuli.vagrant](https://github.com/markosamuli/ansible-vagrant)

## License

MIT

## Authors

- [@markosamuli](https://github.com/markosamuli)
