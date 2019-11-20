# Changelog

## [Unreleased changes] - 2019-11-20

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

### Changed

#### Default installation options

The following tools are no longer installed automatically but require to be
manually enabled:

* NeoVim
* Slack desktop application
* Vagrant and VirtualBox
* Packer

#### Tools

* Check Ansible version when running playbooks
* Makefile with tasks for common playbooks

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
* Changed default GOPATH from `~/Projects/golang` to `~/go`
* Add `GO111MODULES` environment variable into shell configuration

[markosamuli.golang]: https://github.com/markosamuli/ansible-golang

#### AWS tools

* Upgraded [markosamuli.aws_tools] from v1.0.1 to v2.0.0

[markosamuli.aws_tools]: https://github.com/markosamuli/ansible-aws-tools

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

#### Development improvements

* Travis: Fail fast on build errors
* GitHub Actions: Added new pre-commit workflow
* Format Python code with [yapf] pre-commit hook
* Validate shell scripts with [shellcheck] and improve coding style
* Format shell scripts with [shfmt]
* Setup virtualenv with pyenv for local development

[yapf]: https://github.com/google/yapf
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh

## [1.0.0] - 2019-06-09

First release.

[Unreleased changes]: https://github.com/markosamuli/linux-machine/commits/develop
[1.0.0]: https://github.com/markosamuli/linux-machine/releases/tag/v1.0.0
