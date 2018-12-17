# Development Ubuntu Linux Setup

[![Build Status](https://travis-ci.org/markosamuli/linux-machine.svg?branch=master)](https://travis-ci.org/markosamuli/linux-machine)

This is a collection of Ansible roles and tasks to setup a new developer machine on Ubuntu Linux.

This setup has been tested on the Ubuntu 16.04 and 18.04 LTS releases.

See [markosamuli/macos-machine](https://github.com/markosamuli/macos-machine) for my macOS setup.

## Requirements

- Ubuntu 16.04 LTS or higher
- Git installed

## Install

Install Git and curl:

```bash
sudo apt update
sudo apt install curl git
```

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

## Software installed by the playbooks

### Installation tools

The following tools are prequiresites and always installed during setup if not
already found on the system.

- [Ansible](https://www.ansible.com/) from [Ansible PPA](https://launchpad.net/~ansible/+archive/ubuntu/ansible)

### Desktop applications

- [Terminator](https://gnometerminator.blogspot.com/p/introduction.html)
- [Slack](https://snapcraft.io/slack) via Snap package

### Command line tools

- [GNU Wget](https://www.gnu.org/software/wget/)
- [curl](https://curl.haxx.se/)
- [jq](https://stedolan.github.io/jq/) command-line JSON processor
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) code
  searcing utility similar to `ack`
- [htop](https://hisham.hm/htop/)

### Editors

- [Visual Studio Code](https://code.visualstudio.com/) via Snap package
- [Vim](https://www.vim.org/)

### Programming languages and version managers

- [Python]((https://www.python.org/)) and [pip](https://pypi.org/project/pip/) from Ubuntu packages
- [virtualenv](https://virtualenv.pypa.io/en/latest/) from PyPI
- [Node Version Manager](https://github.com/creationix/nvm) (NVM)
- [Node.js](https://nodejs.org/en/) stable installed with NMV
- [virtualenv](https://virtualenv.pypa.io/en/latest/)
- [pyenv](https://github.com/pyenv/pyenv)
- [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
- [Python](https://www.python.org/) v2.7.15 and v3.7.1 installed with pyenv
- [Go programming language](https://golang.org/) 

### Developer tools

- [Git](https://git-scm.com/)
- [Docker Engine](https://docs.docker.com/engine/) Community Edition
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

### DevOps and Cloud tools

- [Terraform](https://www.terraform.io/)
- [Packer](https://packer.io/)
- [Google Cloud SDK](https://cloud.google.com/sdk/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [aws-shell](https://github.com/awslabs/aws-shell) - interactive shell for
  AWS CLI
- [AWS Vault](https://github.com/99designs/aws-vault) - a vault for securely
  storing and accessing AWS credentials in development environments
- [cli53](https://github.com/barnybug/cli53) - command line tool for Amazon
  Route 53

## Changes to existing configuration

The installer creates empty `~/.bash_profile` and `~/.bashrc` files and makes
sure `~/.bashrc` is loaded from `~/.bash_profile`.

The installer makes changes to your `~/.bashrc` and `~/.zshrc` files, so take
backup copies of them before running the script.

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

[MIT](LICENSE)

## Authors

- [@markosamuli](https://github.com/markosamuli)
