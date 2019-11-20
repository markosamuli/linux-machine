# Development Linux Setup

| Branch  | Status |
|---------|--------|
| master  | [![Build Status](https://travis-ci.org/markosamuli/linux-machine.svg?branch=master)](https://travis-ci.org/markosamuli/linux-machine/branches)
| develop | [![Build Status](https://travis-ci.org/markosamuli/linux-machine.svg?branch=develop)](https://travis-ci.org/markosamuli/linux-machine/branches)

This is a collection of Ansible roles and tasks to setup a Linux development
machine.

Read my [Machine Setup Guide][machine-setup-guide] for instructions.

[machine-setup-guide]: https://machine.msk.io/

## Requirements

- [Ubuntu] or another supported operating system
- Git installed
- Bash shell
- [Ansible] 2.7 or newer (some features require Ansible 2.8)
- [Python] 2.7 or 3.7 as required by Ansible

See [markosamuli/macos-machine] for my macOS setup.

[Ansible]: https://www.ansible.com/
[markosamuli/macos-machine]: https://github.com/markosamuli/macos-machine

## Ansible version

The setup script will install Ansible using APT from [Ansible PPAs] if
the `ansible` command is not found on your system.

If an acceptable Ansible APT package installation candidate can't be found
the setup script will try to install Ansible with PIP in a local virtuelenv.

If `virtuelenv` can't be found the setup script the setup will fail.

You can define `MACHINE_ANSIBLE_VERSION` environment variable to change
the installed version.

Example to use Ansible 2.8:

```bash
export MACHINE_ANSIBLE_VERSION=2.8
```

| Version | PPA |
|---------|-----|
| `2.7` | [ansible/ansible-2.7] |
| `2.8` (default) | [ansible/ansible-2.8] |
| `2.9` | [ansible/ansible-2.9] |

[Ansible PPAs]: https://launchpad.net/~ansible
[ansible/ansible-2.7]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.7
[ansible/ansible-2.8]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.8
[ansible/ansible-2.9]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.9

### Ubuntu

This setup has been tested on the [Ubuntu] [16.04 LTS (Xenial Xerus)]
and [18.04 LTS (Bionic Beaver)] releases.

Travis CI builds are running on Ubuntu 16.04.

[Ubuntu]: https://www.ubuntu.com/
[16.04 LTS (Xenial Xerus)]: http://releases.ubuntu.com/16.04/
[18.04 LTS (Bionic Beaver)]: http://releases.ubuntu.com/18.04/

### Ubuntu on WSL

I've also used this playbook to install packages on Ubuntu running on
[Windows Subsystem for Linux] on Windows 10.

Some packages are known not to work so I've added custom fact `is_wsl`
that can be used to check if we're running Linux on Windows and these
will be skipped during the set up.

[Windows Subsystem for Linux]: https://docs.microsoft.com/en-us/windows/wsl/install-win10

### Pengwin on WSL

I've tried installing some of the packages on [Pengwin] distribution.

Ansible installation should be compatible with [pengwin-setup] as found
in the `development` branch.

Tested packages:

- Neovim
- Terraform
- Node.js with NVM
- Python

Known conflicts:

- Pengwin installs Terraform in `/usr/bin/terraform`
- Pengwin installs Node.js with [n npm] instead of NVM

[Pengwin]: https://github.com/WhitewaterFoundry/Pengwin
[pengwin-setup]: https://github.com/WhitewaterFoundry/pengwin-setup
[n npm]: https://github.com/tj/n

## Install

Install Git and curl:

```bash
sudo apt update
sudo apt install curl git
```

You can run the installer script that will clone the code from GitHub and run
the `setup` script.

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

## Local options

You can pass custom variables to the Ansible playbook and roles by creating
a [`machine.yaml`][machine.yaml] file to customise your configuration.

```bash
cp machine.yaml.example machine.yaml
```

The `setup` script will detect if this file exists and passes it to the
Ansible Playbook with `--extra-vars`.

[machine.yaml]: machine.yaml

## Software installed by the playbooks

### Homebrew on Linux (aka Linuxbrew)

[Homebrew] can be installed on Linux by enabled the following option:

```yaml
install_linuxbrew: true
```

Installation will be done using [markosamuli.linuxbrew] Ansible role.

[Homebrew]: https://docs.brew.sh/Homebrew-on-Linux

### Desktop applications

Installed on all environments:

- [Terminator](https://gnometerminator.blogspot.com/p/introduction.html)
- [Hyper](https://hyper.is/)

To install [Slack] desktop application via Snap package:

```yaml
install_slack: true
```

[Slack]: https://snapcraft.io/slack

### Command line tools

- [GNU Wget]
- [curl]
- [jq] command-line JSON processor
- [The Silver Searcher] (`ag` command) code searching utility similar to `ack`
- [htop] process viewer for console
- [pass] — the standard unix password manager

Run tools playbook:

```bash
make tools
```

[GNU Wget]: https://www.gnu.org/software/wget/
[curl]: https://curl.haxx.se/
[jq]: https://stedolan.github.io/jq/
[htop]: https://hisham.hm/htop/
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[pass]: https://www.passwordstore.org/

### Editors

[Visual Studio Code] will be installed on non-WSL environments via Snap package.

See [Developing on WSL] for instructions how to install and use Visual Studio
Code [Remote - WSL] extension.

Latest version of [Vim] will be installed using the package manager.

To install [Neovim] enable it in `machine.yaml`:

```yaml
install_neovim: true
```

[Visual Studio Code]: https://code.visualstudio.com/
[Developing on WSL]: https://code.visualstudio.com/docs/remote/wsl
[Remote - WSL]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl
[Vim]: https://www.vim.org/
[Neovim]: https://neovim.io/

### asdf version manager

You can install [asdf] version manager by adding the following
option to your [`machine.yaml`][machine.yaml]:

```yaml
install_asdf: true
```

To configure [asdf plugins] and package versions to install, add them
into your [`machine.yaml`][machine.yaml] configuration.

```yaml
asdf_plugins:
  - name: kubectl
  - name: concourse
```

[asdf]: https://asdf-vm.com
[asdf plugins]: https://asdf-vm.com/#/plugins-all

### Python

Use Ubuntu/Debian packages to install Python on the system:

- [Python] v2.7 with `python` package
- [pip] with `python-pip` package
- [virtualenv] from PyPI

Use [pyenv] to install and manage Python versions for the current user:

- [pyenv]
- [pyenv-virtualenv]
- [Python] v2.7 and v3.7 installed with pyenv

Run Python playbook:

```bash
make python
```

You can disable installation by adding the following option to
your [`machine.yaml`][machine.yaml]:

```yaml
install_python: false
```

The [markosamuli.pyenv] role will modify your `.bashrc` and `.zshrc` files
during the setup. If you want to disable this, edit `machine.yaml` file
and disable the following configuration option.

```yaml
pyenv_init_shell: false
```

[Python]: https://www.python.org/
[pyenv]: https://github.com/pyenv/pyenv
[pyenv-virtualenv]: https://github.com/pyenv/pyenv-virtualenv

### Ruby

To install Ruby for development, enable it in your `machine.yaml` configuration:

```yaml
install_ruby: true
```

This will install:

- [rbenv] using [zzet.rbenv] role
- [Ruby] version 2.6.3 with rbenv

Run Ruby playbook:

```bash
make ruby
```

To change the installed rubies and default version, add the following to your
`machine.yaml` file and customize it to your needs:

```yaml
rbenv:
  env: user
  version: v1.1.2
  default_ruby: 2.6.3
  rubies:
    - version: 2.6.3
```

The role doesn't update your `.bashrc` or `.zshrc` files but adds a global
initialization script in `/etc/profile.d/rbenv.sh`. If this doesn't work on
your environment, add something like below to initialize rbenv in your shell:

```bash
if [ -z "${RBENV_ROOT}" ]; then
  if [ -d "$HOME/.rbenv" ]; then
    export PATH=$HOME/.rbenv/bin:$PATH;
    export RBENV_ROOT=$HOME/.rbenv;
    eval "$(rbenv init -)";
  fi
fi
```

[zzet.rbenv]: https://github.com/zzet/ansible-rbenv-role
[rbenv]: https://github.com/rbenv/rbenv
[Ruby]: https://www.ruby-lang.org/en/

### Rust

Install [Rust] programming language with [markosamuli.rust] role.

Enable with:

```yaml
install_rust: true
```

To avoid modifying path during install:

```yaml
rust_modify_path: false
```

Run Rust playbook:

```bash
make rust
```

To uninstall Rust, run:

```bash
rustup self uninstall
```

[Rust]: https://www.rust-lang.org/
[markosamuli.rust]: https://github.com/markosamuli/ansible-rust

### Node.js

- [Node Version Manager] (NVM)
- [Node.js] LTS installed with NMV

Run Node.js playbook:

```bash
make node
```

You can disable installation by adding the following option to
your [`machine.yaml`][machine.yaml]:

```yaml
install_nodejs: false
```

[Node Version Manager]: https://github.com/creationix/nvm
[Node.js]: https://nodejs.org/en/

### Go

[Go programming language] installed using [markosamuli.golang]
Ansible role.

Run Go playbook:

```bash
make golang
```

You can disable installation by adding the following option to
your [`machine.yaml`][machine.yaml]:

```yaml
install_golang: false
```

[Go programming language]: https://golang.org/

### Git

Latest version of [Git] will be installed.

[Git]: https://git-scm.com/

### Vagrant and VirtualBox

[Vagrant] and [VirtualBox] are no longer installed by default, but you can
enable them by adding:

```yaml
install_vagrant: true
```

[Vagrant]: https://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/

### Docker

[Docker] will be installed by default.

Run Docker playbook:

```bash
make docker
```

To disable installation, add:

```yaml
install_docker: false
```

[Docker]: https://docs.docker.com/engine/

### Packer

To install [Packer] add:

```yaml
install_packer: true
```

[Packer]: https://packer.io/

### Terraform

Run Terraform playbook:

```bash
make terraform
```

Disable [Terraform] installation with:

```yaml
install_terraform: false
```

[Terraform]: https://www.terraform.io/

### Amazon Web Services

- [AWS CLI](https://aws.amazon.com/cli/)
- [aws-shell](https://github.com/awslabs/aws-shell) - interactive shell for
  AWS CLI
- [AWS Vault](https://github.com/99designs/aws-vault) - a vault for securely
  storing and accessing AWS credentials in development environments
- [cli53](https://github.com/barnybug/cli53) - command line tool for Amazon
  Route 53

You can disable installation by adding the following option to
your [`machine.yaml`][machine.yaml]:

```yaml
install_aws: false
```

### Google Cloud Platform

[Google Cloud SDK] installed from the archive file under user home directory.

Run Google Cloud SDK playbook:

```bash
make gcloud
```

Default install path is in `~/google-cloud-sdk`, but you can
install it to another location, for example if you prefer
`~/opt/google-cloud-sdk` add the following option:

```yaml
gcloud_install_path: ~/opt
```

The [markosamuli.gcloud] role will modify your `.bashrc` and `.zshrc` files.
To disable this and manage the configuration yourself, disable the following
configuration option in the [`machine.yaml`][machine.yaml] file:

```yaml
gcloud_setup_shell: false
```

You can disable installation by adding the following option to
your [`machine.yaml`][machine.yaml]:

```yaml
install_gcloud: false
```

If you prefer to install Google Cloud SDK using package manager, enable it in
the `machine.yaml` configuration file:

```yaml
gcloud_install_from_package_manager: true
```

[Google Cloud SDK]: https://cloud.google.com/sdk/

## Changes to existing configuration

The installer makes changes to your `~/.bashrc` and `~/.zshrc` files, so take
backup copies of them before running the script.

## Ansible Roles

The following external Ansible roles are installed and used. See
[requirements.yml] file for the installed versions.

To install roles and forcibly update any existing ones:

```bash
make roles
```

To update roles to the latest release versions:

```bash
make update
```

| Role | Build status |
|------|--------------|
| [markosamuli.asdf] | [![Build Status](https://travis-ci.org/markosamuli/ansible-asdf.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-asdf) |
| [markosamuli.aws_tools] | [![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-aws-tools) |
| [markosamuli.gcloud] | [![Build Status](https://travis-ci.org/markosamuli/ansible-gcloud.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-gcloud) |
| [markosamuli.golang] | [![Build Status](https://travis-ci.org/markosamuli/ansible-golang.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-golang) |
| [markosamuli.linuxbrew] | [![Build Status](https://travis-ci.org/markosamuli/ansible-linuxbrew.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-linuxbrew) |
| [markosamuli.nvm] | [![Build Status](https://travis-ci.org/markosamuli/ansible-nvm.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-nvm) |
| [markosamuli.packer] | [![Build Status](https://travis-ci.org/markosamuli/ansible-packer.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-packer) |
| [markosamuli.pyenv] | [![Build Status](https://travis-ci.org/markosamuli/ansible-pyenv.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-pyenv) |
| [markosamuli.terraform] | [![Build Status](https://travis-ci.org/markosamuli/ansible-terraform.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-terraform) |
| [markosamuli.vagrant] | [![Build Status](https://travis-ci.org/markosamuli/ansible-vagrant.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-vagrant) |
| [markosamuli.hyper] | [![Build Status](https://travis-ci.org/markosamuli/ansible-hyper.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-hyper) |

[markosamuli.asdf]: https://github.com/markosamuli/ansible-asdf
[markosamuli.aws_tools]: https://github.com/markosamuli/ansible-aws-tools
[markosamuli.gcloud]: https://github.com/markosamuli/ansible-gcloud
[markosamuli.golang]: https://github.com/markosamuli/ansible-golang
[markosamuli.hyper]: https://github.com/markosamuli/ansible-hyper
[markosamuli.linuxbrew]: https://github.com/markosamuli/ansible-linuxbrew
[markosamuli.nvm]: https://github.com/markosamuli/ansible-nvm
[markosamuli.packer]: https://github.com/markosamuli/ansible-packer
[markosamuli.pyenv]: https://github.com/markosamuli/ansible-pyenv
[markosamuli.terraform]: https://github.com/markosamuli/ansible-terraform
[markosamuli.vagrant]: https://github.com/markosamuli/ansible-vagrant
[requirements.yml]: requirements.yml

## Development

Fix ansible-lint installation issues:

```bash
pip install virtualenv==16.3.0
```

Install [pre-commit] hooks:

```bash
make install-git-hooks
```

Lint code and configuration:

```bash
make lint
```

[pre-commit]: https://pre-commit.com/

## References

This is based on my previous setup [markosamuli/machine] that was forked off
from  [caarlos0/machine] to suit my needs.

[markosamuli/machine]: https://github.com/markosamuli/machine
[caarlos0/machine]: https://github.com/caarlos0/machine

## License

- [MIT](LICENSE)

## Authors

- [@markosamuli](https://github.com/markosamuli)
