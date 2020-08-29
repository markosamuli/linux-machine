# Changelog

## Ubuntu 20.04 LTS and WSL2 - 2020-08-29

Changes in the `feature/ubuntu-20.04lts` branch while testing the current
playbooks on Ubuntu 20.04 LTS and WSL2.

### Breaking changes

- Remove support for installing Python 2.7 using APT packages
- Require Ansible 2.9 on Ubuntu 20.04 LTS

### Fixed

Role updates:

- Use [`markosamuli.golang`][markosamuli.golang] v1.3.1

Fixes for WSL2:

- Detect WSL2 installations using `/run/WSL` directory

Fixes for Ubuntu 20.04 LTS:

- Install `make`
- Set `ansible_python_interpreter` to `/usr/bin/python3`
- Do not install Ansible from PPA as it's not available and the default
  APT package already has Ansible v2.9
- Do not install `shellcheck` from Snap

### Changed

- Install Ansible 2.9 on Ubuntu 20.04 LTS
- Install Python using `python3` and `python3-pip` packages instead of `python`
  and `python-pip`
- Using local `python` role for installing Python
- Using local `shellcheck` role for installing Shellcheck

## Ubuntu 19.10 and Ansible 2.8 - 2020-02-16

This includes changes in the `feature/ansible2.8` branch that were never
released or merged into the `develop` branch.

### Breaking changes

- The setup script and Ansible playbooks will require [Ansible 2.8][ansible28]
  to include support for installing software via [snap] packages.
- Use [markosamuli.pyenv] v3.0.0 and remove Python 2.7 support

[ansible28]: https://docs.ansible.com/ansible/2.8/index.html
[snap]: https://snapcraft.io/

### Added

Shell:

- Install Zsh by default

New developer CLI tools:

- Install [ShellCheck][shellcheck] via snap

[shellcheck]: https://github.com/koalaman/shellcheck

New developer tools for desktop use:

- Install [Terminus][terminus] terminal application
- Install [Meld][meld], a visual diff and merge tool

[terminus]: https://eugeny.github.io/terminus/
[meld]: https://meldmerge.org/

Productivity tools for desktop use:

- Install [LibreOffice][libreoffice] productivity suite

[libreoffice]: https://www.libreoffice.org/

Antivirus and security tools:

- Install [ClamAV][clamav] antivirus software
- Install [Lynis][lynis] security tool for auditing the system

[clamav]: https://www.clamav.net/
[lynis]: https://cisofy.com/lynis/

Optional security hardening tools:

- [passwdqc][passwdqc] for password/passphrase strength checking and enforcement
- [USBGuard][usbguard] for protecting system against rogue USB devices
- [debsums][debsums] tool for verification of installed package files against
  MD5 checksums

[passwdqc]: https://www.openwall.com/passwdqc/
[usbguard]: https://usbguard.github.io/
[debsums]: https://packages.ubuntu.com/eoan/debsums

Optional system monitoring tools:

- [GNU Accounting utilities][acct] for process and login accounting
- [sysstat] - Performance monitoring tools for Linux

[acct]: https://www.gnu.org/software/acct/
[sysstat]: https://github.com/sysstat/sysstat

Install additional Go tools for development:

- [errcheck] is a program for checking for unchecked errors in go programs
- [go-callvis] is a development tool to help visualize call graph of a Go
  program using interactive view
- [gopkgs] is a tool that provides list of available Go packages that can be
  imported
- [Stringer][stringer] is a tool to automate the creation of methods that
  satisfy the fmt.Stringer interface
- [guru] is a tool for answering questions about Go source code
- [staticcheck] is a linter for Go source code

[errcheck]: https://github.com/kisielk/errcheck
[go-callvis]: https://github.com/TrueFurby/go-callvis
[gopkgs]: https://github.com/uudashr/gopkgs
[stringer]: https://godoc.org/golang.org/x/tools/cmd/stringer
[guru]: https://godoc.org/golang.org/x/tools/cmd/guru
[staticcheck]: https://godoc.org/honnef.co/go/tools/staticcheck

### Fixed

Issues fixed in this release:

- Suppress errors in `Makefile` when `pyenv` is not installed
- Prevent [pre-commit] from being upgraded to version 2
- Use the correct `nvm_shell_init` variable instead of `nvm_init_shell` in the
  `machine.msk.yaml` config file

### Changes

The following changes have been made to the development and setup tooling:

- Install [shfmt] and [shellcheck] as a dependency in the Makefile
- Use [shfmt] v3 for formatting bash scripts
- Added `make editors` command
- Use [Prettier][prettier] for formatting JSON, Markdown and YAML files
- Added my current `machine.yaml` configuration file into the repository
- Added script for automatic `machine.yaml` file configuration

Node.js and Python versions:

- Install Node.js v12.x
- Install Python 3.7.6

[prettier]: https://prettier.io/

## [2.1.0] - 2019-11-24

### Added

- Fix permissions in user home directory
- Install [pass] unix password manager
- Added [aws-vault] plugin for [asdf] version manager

[pass]: https://www.passwordstore.org/
[asdf]: https://asdf-vm.com/
[aws-vault]: https://github.com/99designs/aws-vault

#### Homebrew on Linux (aka Linuxbrew)

- Install [Homebrew on Linux] using [markosamuli.linuxbrew] v1.2.0

[homebrew on linux]: https://docs.brew.sh/Homebrew-on-Linux
[markosamuli.linuxbrew]: https://github.com/markosamuli/ansible-linuxbrew

#### Lua

- Install [Lua] programming language and [LuaRocks] package manager for Lua
- Install [luacheck] rock using the custom [luarocks module]

[lua]: https://www.lua.org/
[luarocks]: https://luarocks.org/
[luacheck]: https://github.com/mpeterv/luacheck
[luarocks module]: playbooks/library/luarocks.py

#### Ruby

- Install [rbenv] and [Ruby] with [zzet.rbenv] v3.4.7
- Install rbenv v1.1.2
- Install Ruby v2.6.3

[zzet.rbenv]: https://github.com/zzet/ansible-rbenv-role
[rbenv]: https://github.com/rbenv/rbenv
[ruby]: https://www.ruby-lang.org/en/

#### Rust

- Install [Rust] programming language with [markosamuli.rust]

[rust]: https://www.rust-lang.org/
[markosamuli.rust]: https://github.com/markosamuli/ansible-rust

### Fixed

- Use `bash` executable instead of `sh` with Ansible on WSL environments to
  get around Windows directory white spaces on the PATH. Fixes issues with
  `zzet.rbenv` role no longer using bash for executing shell commands.
- Fix `update-roles.py` script not working if using master as version in
  `requirements.yml` file.

### Changed

#### Ansible

- Require minimum Ansible version 2.7
- Install Ansible 2.8 as the default version
- Check that we're not using broken Ansible v2.8.6
- Check Ansible version when running playbooks

#### Setup script

- Rework on the setup script for improved Ansible installation when using
  pyenv or virtualenv or calling Ansible with any non-system paths.
- Support for installing Ansible in a local virtualenv from PyPI.
- Allow setting the default Ansible version with `MACHINE_ANSIBLE_VERSION`
  environment variable.
- Added support for uninstalling existing Ansible installations.
- Added new long command line options in the setup script.

#### Default installation options

The following tools are no longer installed automatically but require to be
manually enabled:

- NeoVim
- Slack desktop application
- Vagrant and VirtualBox
- Packer

#### Terraform

- Remove Terraform installed with [markosamuli.terraform] if Terraform
  installation with [asdf] version manager is found

#### asdf version manager

- Upgraded [markosamuli.asdf] from v1.0.0 to v1.1.0
- Added `asdf_init_shell` option for skipping shell configuration

[markosamuli.asdf]: https://github.com/markosamuli/ansible-asdf

#### Hyper

- Upgraded [markosamuli.hyper] from v1.1.0 to v1.2.0

[markosamuli.hyper]: https://github.com/markosamuli/ansible-hyper

#### Golang

- Upgraded [markosamuli.golang] from v1.0.0 to v1.2.1
- Optional shell script initialization
- Install common Go packages with the [markosamuli.golang] role
- Changed default `GOPATH` from `~/Projects/golang` to `~/go`
- Add `GO111MODULES` environment variable into shell configuration

[markosamuli.golang]: https://github.com/markosamuli/ansible-golang

#### AWS tools

- Upgraded [markosamuli.aws_tools] from v1.0.1 to v2.1.0
- Install packages under `~/.aws-tools`
- Added `aws-tools-update` script for updating packages in the virtualenv
- Update [cli53] to v0.8.16
- Update [aws-vault] to v4.7.1

The previous release installed packages under `/opt/aws-tools` and created
symbolic links to `/usr/local/bin`. These will be removed automatically.

[markosamuli.aws_tools]: https://github.com/markosamuli/ansible-aws-tools
[cli53]: https://github.com/barnybug/cli53
[aws-vault]: https://github.com/99designs/aws-vault

#### Google Cloud SDK

- Upgraded [markosamuli.gcloud] from v1.1.1 to v2.1.2
- Install Google Cloud SDK from an archive file instead of the APT repository
- Cloud SDK release 271.0.0
- Option for preferring `python3` over `python2` during install

[markosamuli.gcloud]: https://github.com/markosamuli/ansible-gcloud

#### Node.js

- Upgraded [markosamuli.nvm] from v1.3.0 to v1.4.1
- Install NVM v0.35.1
- Load bash completion in shell scripts

[markosamuli.nvm]: https://github.com/markosamuli/ansible-nvm

#### Python

- Upgraded [markosamuli.pyenv] from v1.5.1 to v2.1.1
- Update to [pyenv 1.2.15]
- Update to [Python 2.7.17]
- Update to [Python 3.7.5]

[markosamuli.pyenv]: https://github.com/markosamuli/ansible-pyenv
[pyenv 1.2.15]: https://github.com/pyenv/pyenv/releases/tag/v1.2.15
[python 2.7.17]: https://www.python.org/downloads/release/python-2717/
[python 3.7.5]: https://www.python.org/downloads/release/python-375/

#### Makefile

- Added Makefile with tasks for common playbooks.
- Self-documented Makefile and `make help` command.
- Added `setup` command for running `setup` script with the default options.
- Removed `setup-ansible` and `setup-ansible-pypi` Makefile commands.
- Added `install-ansible` Makefile command that doesn't enable or disable PyPI
  and doesn't reinstall existing Ansible installations.
- Playbook short commands in Makefile will automatically install missing Ansible
  roles.
- Added `linuxbrew` Makefile command.
- Renamed `roles` Makefile command to `install-roles` and removed `-f` argument.
- Renamed `update` Makefile command to `update-roles`.
- Added `clean-roles` Makefile command for running `clean_roles.py` script.
- Added `latest-roles` Makefile command to update, clean and install required
  Ansible roles to their latest versions.

#### Travis

- Fail fast on build errors
- Run builds with Ansible 2.7, 2.8 and 2.9
- Do not test manually installing PyPI

#### Python scripts

- Moved Python business logic and shared functionality from the Python scripts
  into a local `machine` Python package.

#### Development and coding style improvements

- Added new pre-commit workflow in GitHub Actions
- Removed `autopep8` in favour of using `yapf` for formatting Python code
- Added `pylint` pre-commit hooks for linting Python code
- Format Python code with [yapf] pre-commit hook
- Validate shell scripts with [shellcheck] and improve coding style
- Format shell scripts with [shfmt]
- Setup virtualenv with pyenv for local development
- Added `clean-roles.py` script for removing outdated Ansible roles.
- Move development requirements from `requirements.txt` into a separate
  `requirements.dev.txt` file to avoid installing those during normal usage.

[yapf]: https://github.com/google/yapf
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh

## [1.0.0] - 2019-06-09

First release.

[unreleased changes]: https://github.com/markosamuli/linux-machine/commits/develop
[2.1.0]: https://github.com/markosamuli/linux-machine/releases/tag/v2.1.0
[2.0.0]: https://github.com/markosamuli/linux-machine/releases/tag/v2.0.0
[1.0.0]: https://github.com/markosamuli/linux-machine/releases/tag/v1.0.0
