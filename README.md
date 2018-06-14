Development Ubuntu Linux Setup
==============================

[![Build Status](https://travis-ci.org/markosamuli/linux-machine.svg?branch=master)](https://travis-ci.org/markosamuli/linux-machine)

This is a collection of Ansible roles and tasks to setup a new developer machine on Ubuntu Linux.

This setup has only been tested on the Ubuntu 18.04 LTS and not against existing installations.

Requirements
------------

- Ubuntu 18.04 LTS or higher
- Git installed

Install
-------

You can run the installer script that will clone the code from GitHub and run the `setup` script.

```
curl -s https://raw.githubusercontent.com/markosamuli/linux-machine/master/install.sh | bash -
```

Getting Started
---------------

Clone this project locally and run the `./setup` script.

```bash
git clone https://github.com/markosamuli/linux-machine
cd linux-machine
./setup
```

Ansible Roles
-------------

The following external Ansible roles are installed and used:

- [markosamuli.terraform](https://github.com/markosamuli/ansible-terraform)
- [markosamuli.packer](https://github.com/markosamuli/ansible-packer)
- [markosamuli.aws-tools](https://github.com/markosamuli/ansible-aws-tools)
- [markosamuli.cloud](https://github.com/markosamuli/ansible-cloud)
- [markosamuli.nvm](https://github.com/markosamuli/ansible-nvm)
- [markosamuli.vagrant](https://github.com/markosamuli/ansible-vagrant)

License
-------

MIT

Authors
-------

- [@markosamuli](https://github.com/markosamuli)
