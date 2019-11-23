# Changelog

## [Unreleased changes] - 2019-11-23

### Added

* Fix permissions in user home directory
* Install [pass] unix password manager
* Added [aws-vault] plugin for [asdf] version manager

[pass]: https://www.passwordstore.org/
[asdf]: https://asdf-vm.com/
[aws-vault]: https://github.com/99designs/aws-vault

#### Homebrew on Linux (aka Linuxbrew)

* Install [Homebrew on Linux] using [markosamuli.linuxbrew] v1.2.0

[Homebrew on Linux]: https://docs.brew.sh/Homebrew-on-Linux
[markosamuli.linuxbrew]: https://github.com/markosamuli/ansible-linuxbrew

#### Ruby

* Install [rbenv] and [Ruby] with [zzet.rbenv] v3.4.7
* Install rbenv v1.1.2
* Install Ruby v2.6.3

[zzet.rbenv]: https://github.com/zzet/ansible-rbenv-role
[rbenv]: https://github.com/rbenv/rbenv
[Ruby]: https://www.ruby-lang.org/en/

#### Rust

* Install [Rust] programming language with [markosamuli.rust]

[Rust]: https://www.rust-lang.org/
[markosamuli.rust]: https://github.com/markosamuli/ansible-rust

### Fixed

* Use `bash` executable instead of `sh` with Ansible on WSL environments to
  get around Windows directory white spaces on the PATH. Fixes issues with
  `zzet.rbenv` role no longer using bash for executing shell commands.
* Fix `update-roles.py` script not working if using master as version in
  `requirements.yml` file.

### Changed

#### Ansible

* Require minimum Ansible version 2.7
* Install Ansible 2.8 as the default version
* Check that we're not using broken Ansible v2.8.6
* Check Ansible version when running playbooks

#### Setup script

* Rework on the setup script for improved Ansible installation when using
  pyenv or virtualenv or calling Ansible with any non-system paths.
* Support for installing Ansible in a local virtualenv from PyPI.
* Allow setting the default Ansible version with `MACHINE_ANSIBLE_VERSION`
  environment variable.
* Added support for uninstalling existing Ansible installations.
* Added new long command line options in the setup script.

#### Default installation options

The following tools are no longer installed automatically but require to be
manually enabled:

* NeoVim
* Slack desktop application
* Vagrant and VirtualBox
* Packer

#### Terraform

* Remove Terraform installed with [markosamuli.terraform] if Terraform
  installation with [asdf] version manager is found

#### asdf version manager

* Upgraded [markosamuli.asdf] from v1.0.0 to v1.1.0
* Added `asdf_init_shell` option for skipping shell configuration

[markosamuli.asdf]: https://github.com/markosamuli/ansible-asdf

#### Hyper

* Upgraded [markosamuli.hyper] from v1.1.0 to v1.2.0

[markosamuli.hyper]: https://github.com/markosamuli/ansible-hyper

#### Golang

* Upgraded [markosamuli.golang] from v1.0.0 to v1.2.1
* Optional shell script initialization
* Install common Go packages with the [markosamuli.golang] role
* Changed default `GOPATH` from `~/Projects/golang` to `~/go`
* Add `GO111MODULES` environment variable into shell configuration

[markosamuli.golang]: https://github.com/markosamuli/ansible-golang

#### AWS tools

* Upgraded [markosamuli.aws_tools] from v1.0.1 to v2.1.0
* Install packages under `~/.aws-tools`
* Added `aws-tools-update` script for updating packages in the virtualenv
* Update [cli53] to v0.8.16
* Update [aws-vault] to v4.7.1

The previous release installed packages under `/opt/aws-tools` and created
symbolic links to `/usr/local/bin`. These will be removed automatically.

[markosamuli.aws_tools]: https://github.com/markosamuli/ansible-aws-tools
[cli53]: https://github.com/barnybug/cli53
[aws-vault]: https://github.com/99designs/aws-vault

#### Google Cloud SDK

* Upgraded [markosamuli.gcloud] from v1.1.1 to v2.1.1
* Install Google Cloud SDK from an archive file instead of the APT repository
* Cloud SDK release 271.0.0

[markosamuli.gcloud]: https://github.com/markosamuli/ansible-gcloud

#### Node.js

* Upgraded [markosamuli.nvm] from v1.3.0 to v1.4.1
* Install NVM v0.35.1
* Load bash completion in shell scripts

[markosamuli.nvm]: https://github.com/markosamuli/ansible-nvm

#### Python

* Upgraded [markosamuli.pyenv] from v1.5.1 to v2.1.1
* Update to [pyenv 1.2.15]
* Update to [Python 2.7.17]
* Update to [Python 3.7.5]

[markosamuli.pyenv]: https://github.com/markosamuli/ansible-pyenv
[pyenv 1.2.15]: https://github.com/pyenv/pyenv/releases/tag/v1.2.15
[Python 2.7.17]: https://www.python.org/downloads/release/python-2717/
[Python 3.7.5]: https://www.python.org/downloads/release/python-375/

#### Makefile

* Added Makefile with tasks for common playbooks.
* Self-documented Makefile and `make help` command.
* Added `setup` command for running `setup` script with the default options.
* Removed `setup-ansible` and `setup-ansible-pypi` Makefile commands.
* Added `install-ansible` Makefile command  that doesn't enable or disable PyPI
  and doesn't reinstall existing Ansible installations.
* Playbook short commands in Makefile will automatically install missing Ansible
  roles.
* Added `linuxbrew` Makefile command.
* Renamed `roles` Makefile command to  `install-roles` and removed `-f` argument.
* Renamed `update` Makefile command to  `update-roles`.
* Added `clean-roles` Makefile command for running `clean-roles.py` script.
* Added `latest-roles` Makefile command to update, clean and install required
  Ansible roles to their latest versions.

#### Travis

* Fail fast on build errors
* Run builds with Ansible 2.7, 2.8 and 2.9
* Do not test manually installing PyPI

#### Development improvements

* Added new pre-commit workflow in GitHub Actions
* Format Python code with [yapf] pre-commit hook
* Validate shell scripts with [shellcheck] and improve coding style
* Format shell scripts with [shfmt]
* Setup virtualenv with pyenv for local development
* Added `clean-roles.py` script for removing outdated Ansible roles.
* Move development requirements from `requirements.txt` into a separate
  `requirements.dev.txt` file to avoid installing those during normal usage.

[yapf]: https://github.com/google/yapf
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh

## [1.0.0] - 2019-06-09

First release.

[Unreleased changes]: https://github.com/markosamuli/linux-machine/commits/develop
[1.0.0]: https://github.com/markosamuli/linux-machine/releases/tag/v1.0.0
