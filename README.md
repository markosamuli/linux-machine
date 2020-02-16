# Development Linux Setup

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

| Branch  | Build Status                              | Coding Style                |
| ------- | ----------------------------------------- | --------------------------- |
| master  | [![Build Status][travis-master]][travis]  | ![Coding Style][cs-master]  |
| develop | [![Build Status][travis-develop]][travis] | ![Coding Style][cs-develop] |

This is a collection of Ansible roles and tasks to setup a Linux development
machine.

Read my [Machine Setup Guide][machine-setup-guide] for instructions.

[machine-setup-guide]: https://machine.msk.io/
[travis]: https://travis-ci.org/markosamuli/linux-machine/branches
[travis-master]: https://travis-ci.org/markosamuli/linux-machine.svg?branch=master
[travis-develop]: https://travis-ci.org/markosamuli/linux-machine.svg?branch=develop
[cs-master]: https://github.com/markosamuli/linux-machine/workflows/Test/badge.svg?branch=master
[cs-develop]: https://github.com/markosamuli/linux-machine/workflows/Test/badge.svg?branch=develop

## Requirements

- [Ubuntu][ubuntu] or another supported operating system
- Git installed
- Bash shell
- [Ansible][ansible] 2.7 or newer (some features require Ansible 2.8)
- [Python][python] 2.7 or 3.7 as required by Ansible

See [markosamuli/macos-machine] for my macOS setup.

[ubuntu]: https://www.ubuntu.com
[ansible]: https://www.ansible.com/
[markosamuli/macos-machine]: https://github.com/markosamuli/macos-machine

### Ubuntu

This setup has been tested on the following Ubuntu releases:

- Ubuntu [16.04 LTS (Xenial Xerus)][xenial]
- Ubuntu [18.04 LTS (Bionic Beaver)][bionic]
- Ubuntu [19.10 (Eoan Ermine)][eoan]

Travis CI builds are running on Ubuntu 16.04.

[ubuntu]: https://www.ubuntu.com/
[xenial]: http://releases.ubuntu.com/16.04/
[bionic]: http://releases.ubuntu.com/18.04/
[eoan]: http://releases.ubuntu.com/19.10/

### Ubuntu on WSL

I've also used this playbook to install packages on Ubuntu running on
[Windows Subsystem for Linux][wsl] on Windows 10.

Some packages are known not to work so I've added custom fact `is_wsl`
that can be used to check if we're running Linux on Windows and these
will be skipped during the set up.

[wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10

### Pengwin on WSL

I've tried installing some of the packages on [Pengwin][pengwin] distribution.

Ansible installation should be compatible with [pengwin-setup] as found
in the `development` branch.

Tested packages:

- Neovim
- Terraform
- Node.js with NVM
- Python

Known conflicts:

- Pengwin installs Terraform in `/usr/bin/terraform`
- Pengwin installs Node.js with [n npm][tjn] instead of NVM

[pengwin]: https://github.com/WhitewaterFoundry/Pengwin
[pengwin-setup]: https://github.com/WhitewaterFoundry/pengwin-setup
[tjn]: https://github.com/tj/n

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

You can also use my customizations:

```bash
ln -s machine.msk.yaml machine.yaml
```

The `setup` script will detect if this file exists and passes it to the
Ansible Playbook with `--extra-vars`.

[machine.yaml]: machine.yaml

## Ansible

The setup script will try to install Ansible

### Ansible version

Ansible version 2.8 is installed by default.

You can define `MACHINE_ANSIBLE_VERSION` environment variable to change
the installed version.

Example to use Ansible 2.9 instead of Ansible 2.8:

```bash
export MACHINE_ANSIBLE_VERSION=2.9
```

### Force Ansible reinstall

To remove existing Ansible versions and force installation of Ansible, you
can use the `--reinstall-ansible` argument, for example:

```bash
./setup --reinstall-ansible
```

### Installing Ansible with APT

The setup script will install Ansible using APT from
[Ansible PPAs][ansible-ppa] if the `ansible` command is not found on your
system.

| Version         | PPA                   |
| --------------- | --------------------- |
| `2.7`           | [ansible/ansible-2.7] |
| `2.8` (default) | [ansible/ansible-2.8] |
| `2.9`           | [ansible/ansible-2.9] |

[ansible-ppa]: https://launchpad.net/~ansible
[ansible/ansible-2.7]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.7
[ansible/ansible-2.8]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.8
[ansible/ansible-2.9]: https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.9

### Installing Ansible from PyPI into virtualenv

If an acceptable Ansible APT package installation candidate can't be found
the setup script will try to install Ansible with [pip] in a local virtuelenv.

If [virtuelenv] can't be found the setup script the setup will fail.

You can disable installation from PyPI with `--disable-ansible-pypi` argument,
for example:

```bash
./setup --disable-ansible-pypi
```

[pip]: https://pypi.org/project/pip/
[virtuelenv]: https://virtualenv.pypa.io/en/latest/

### Installing Ansible from PyPI into pyenv environment

If the user has set up a local development environment with [pyenv] and this is
defined in a `.python-version` file in the repository root, the setup script
will install Ansible into this environment.

Same as with the local virtualenv, you can disable installation from PyPI
with `--disable-ansible-pypi` argument, for example:

```bash
./setup --disable-ansible-pypi
```

[pyenv]: https://github.com/pyenv/pyenv

## Software installed by the playbooks

### Zsh

Zsh is installed by default. You can disable this in the configuration:

```yaml
install_zsh: false
```

### Homebrew on Linux (aka Linuxbrew)

[Homebrew][homebrew] can be installed on Linux by enabled the following option:

```yaml
install_linuxbrew: true
```

To enable and install:

```bash
make linuxbrew
```

Installation will be done using [markosamuli.linuxbrew] Ansible role.

[homebrew]: https://docs.brew.sh/Homebrew-on-Linux

### Terminals for desktop environments

Installed on all non-WSL environments:

- [Terminator][terminator]
- [Hyper][hyper]
- [Terminus][terminus]

[terminator]: https://gnometerminator.blogspot.com/p/introduction.html
[hyper]: https://hyper.is/
[terminus]: https://eugeny.github.io/terminus/

### Developer tools

Installed on all non-WSL environments:

- [Meld][meld], a visual diff and merge tool

[meld]: https://meldmerge.org/

### Slack

To install [Slack][slack] desktop application via Snap package:

```yaml
install_slack: true
```

[slack]: https://snapcraft.io/slack

### Productivity applications

Installed on non-WSL environments:

- [LibreOffice][libreoffice]

To enable and install:

```bash
make productivity
```

To disable:

```yaml
install_productivity: false
```

[libreoffice]: https://www.libreoffice.org/

### Antivirus

Antivirus software can be installed:

- [ClamAV][clamav]

To enable and install:

```bash
make antivirus
```

To enable manually:

```yaml
install_antivirus: true
```

[clamav]: https://www.clamav.net/

### Security tools

Security tools that can be installed:

- [Lynis][lynis] security tool

To enable and run the security playbook:

```bash
make security
```

To enable manually:

```yaml
install_security: true
```

[lynis]: https://cisofy.com/lynis/

### Security hardening

Install optional security hardening tools:

- [passwdqc][passwdqc] for password/passphrase strength checking and enforcement
- [USBGuard][usbguard] for protecting system against rogue USB devices
- [debsums][debsums] tool for verification of installed package files against
  MD5 checksums

To enable and run the security hardening playbook:

```bash
make security-hardening
```

To enable manually:

```yaml
install_security_hardening: true
```

[passwdqc]: https://www.openwall.com/passwdqc/
[usbguard]: https://usbguard.github.io/
[debsums]: https://packages.ubuntu.com/eoan/debsums

### Monitoring

Install optional system monitoring tools:

- [GNU Accounting utilities][acct] for process and login accounting
- [sysstat] - Performance monitoring tools for Linux

To enable and run the monitoring playbook:

```bash
make monitoring
```

To enable manually:

```yaml
install_monitoring: true
```

[acct]: https://www.gnu.org/software/acct/
[sysstat]: https://github.com/sysstat/sysstat

### Command line tools

- [GNU Wget][wget]
- [curl]
- [jq] command-line JSON processor
- [The Silver Searcher][ag] (`ag` command) code searching utility similar
  to `ack`
- [htop] process viewer for console
- [pass] — the standard unix password manager
- [ShellCheck][shellcheck], a static analysis tool for shell scripts

Run the tools playbook:

```bash
make tools
```

[wget]: https://www.gnu.org/software/wget/
[curl]: https://curl.haxx.se/
[jq]: https://stedolan.github.io/jq/
[htop]: https://hisham.hm/htop/
[ag]: https://github.com/ggreer/the_silver_searcher
[pass]: https://www.passwordstore.org/
[shellcheck]: https://github.com/koalaman/shellcheck

### Visual Studio Code

[Visual Studio Code][vscode] will be installed on non-WSL environments via Snap
package.

See [Developing on WSL][vscode-dev-wsl] for instructions how to install and use
Visual Studio Code [Remote - WSL][vscode-remote-wsl] extension.

[vscode]: https://code.visualstudio.com/
[vscode-dev-wsl]: https://code.visualstudio.com/docs/remote/wsl
[vscode-remote-wsl]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl

### Vim

Latest version of [Vim] will be installed using the package manager.

To install [Neovim] enable it in `machine.yaml`:

```yaml
install_neovim: true
```

[vim]: https://www.vim.org/
[neovim]: https://neovim.io/

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

- [Python] with `python` package — installed Python version will depend on the
  OS release version
- [pip] with `python-pip` package
- [virtualenv] from PyPI

Use [pyenv] to install and manage Python versions for the current user:

- [pyenv]
- [pyenv-virtualenv]
- [Python] v3.7 installed with pyenv

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

[python]: https://www.python.org/
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
[ruby]: https://www.ruby-lang.org/en/

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

[rust]: https://www.rust-lang.org/
[markosamuli.rust]: https://github.com/markosamuli/ansible-rust

### Node.js

- [Node Version Manager](NVM)
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

[node version manager]: https://github.com/creationix/nvm
[node.js]: https://nodejs.org/en/

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

[go programming language]: https://golang.org/

Go tools installed for development:

- [golint] is a linter for Go source code
- [goimports] is a tool for updating your Go import lines
- [errcheck] is a program for checking for unchecked errors in go programs
- [go-callvis] is a development tool to help visualize call graph of a Go
  program using interactive view
- [gopkgs] is a tool that provides list of available Go packages that can be
  imported
- [Stringer][stringer] is a tool to automate the creation of methods that
  satisfy the fmt.Stringer interface
- [guru] is a tool for answering questions about Go source code
- [staticcheck] is a linter for Go source code

[golint]: https://godoc.org/golang.org/x/lint
[goimports]: https://godoc.org/golang.org/x/tools/cmd/goimports
[errcheck]: https://github.com/kisielk/errcheck
[go-callvis]: https://github.com/TrueFurby/go-callvis
[gopkgs]: https://github.com/uudashr/gopkgs
[stringer]: https://godoc.org/golang.org/x/tools/cmd/stringer
[guru]: https://godoc.org/golang.org/x/tools/cmd/guru
[staticcheck]: https://godoc.org/honnef.co/go/tools/staticcheck

### Lua

You can install [Lua][lua] programming language by adding the following option
to your [`machine.yaml`][machine.yaml] file:

```yaml
install_lua: true
```

Run Lua playbook:

```bash
make lua
```

This will also install [LuaRocks][luarocks] package manager and [luacheck]
rock using the custom [luarocks module][luarocks-py].

[lua]: https://www.lua.org/
[luarocks]: https://luarocks.org/
[luacheck]: https://github.com/mpeterv/luacheck
[luarocks-py]: playbooks/library/luarocks.py

### Git

Latest version of [Git][git] will be installed.

[git]: https://git-scm.com/

### Vagrant and VirtualBox

[Vagrant][vagrant] and [VirtualBox][virtualbox] are no longer installed by
default, but you can enable them by adding:

```yaml
install_vagrant: true
```

[vagrant]: https://www.vagrantup.com/
[virtualbox]: https://www.virtualbox.org/

### Docker

[Docker][docker] will be installed by default.

Run Docker playbook:

```bash
make docker
```

To disable installation, add:

```yaml
install_docker: false
```

[docker]: https://docs.docker.com/engine/

### Packer

To install [Packer][packer] add:

```yaml
install_packer: true
```

[packer]: https://packer.io/

### Terraform

Run Terraform playbook:

```bash
make terraform
```

Disable [Terraform][terraform] installation with:

```yaml
install_terraform: false
```

[terraform]: https://www.terraform.io/

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

[Google Cloud SDK][cloud-sdk] installed from the archive file under user home
directory.

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

To prefer `python3` over `python2` during Google Cloud SDK install:

```yaml
gcloud_prefer_python3: true
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

[cloud-sdk]: https://cloud.google.com/sdk/

## Changes to existing configuration

The installer makes changes to your `~/.bashrc` and `~/.zshrc` files, so take
backup copies of them before running the script.

## Ansible Roles

The following external Ansible roles are installed and used. See
[requirements.yml] file for the installed versions.

To install roles:

```bash
make install-roles
```

To update roles to the latest release versions:

```bash
make update-roles
```

To remove any outdated roles:

```bash
make clean-roles
```

| Role                    | Build status                                                                                                                                  |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [markosamuli.asdf]      | [![Build Status](https://travis-ci.org/markosamuli/ansible-asdf.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-asdf)           |
| [markosamuli.aws_tools] | [![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-aws-tools) |
| [markosamuli.gcloud]    | [![Build Status](https://travis-ci.org/markosamuli/ansible-gcloud.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-gcloud)       |
| [markosamuli.golang]    | [![Build Status](https://travis-ci.org/markosamuli/ansible-golang.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-golang)       |
| [markosamuli.linuxbrew] | [![Build Status](https://travis-ci.org/markosamuli/ansible-linuxbrew.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-linuxbrew) |
| [markosamuli.nvm]       | [![Build Status](https://travis-ci.org/markosamuli/ansible-nvm.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-nvm)             |
| [markosamuli.packer]    | [![Build Status](https://travis-ci.org/markosamuli/ansible-packer.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-packer)       |
| [markosamuli.pyenv]     | [![Build Status](https://travis-ci.org/markosamuli/ansible-pyenv.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-pyenv)         |
| [markosamuli.terraform] | [![Build Status](https://travis-ci.org/markosamuli/ansible-terraform.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-terraform) |
| [markosamuli.vagrant]   | [![Build Status](https://travis-ci.org/markosamuli/ansible-vagrant.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-vagrant)     |
| [markosamuli.hyper]     | [![Build Status](https://travis-ci.org/markosamuli/ansible-hyper.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-hyper)         |

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
from [caarlos0/machine] to suit my needs.

[markosamuli/machine]: https://github.com/markosamuli/machine
[caarlos0/machine]: https://github.com/caarlos0/machine

## License

- [MIT](LICENSE)

## Authors

- [@markosamuli](https://github.com/markosamuli)
