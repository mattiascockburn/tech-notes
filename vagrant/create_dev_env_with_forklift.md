Creating Dev Environments with the help of Vagrant/Forklift and Ansible
=======================================================================

Intro
-----

I heavily use vagrant to test software as well as create disposable environments for
use at my daily job (Linux/FLOSS consulting/training). For this i created a very hacky
project skeleton which is not scalable anymore (and i also don't want to touch it again ^^)
The new target infrastructure uses vagrant (duh!), Virtualbox/libvirt as hypervisors, forklift as a
helper library and ansible for provisioning. I will also use some vagrant plugins like hostmanager,
vbguest and sshfs.
This readme targets only Linux. If you have hints about other platforms, feel
free to hit me up on the Interwebs and these will be added to this guide

General Prep
------------

Install vagrant as well as a supported hypervisor and needed tools on your box. This varies from distro to distro.
These are the steps needed for Archlinux (using VirtualBox as hypervisor):

```sh
sudo pacman -S vagrant virtualbox git ansible 
```

Vagrant Plugins
---------------

Install the necessary vagrant plugins

```sh
vagrant plugin install vagrant-vbguest vagrant-hostmanager vagrant-sshfs
```

Repository Prep
---------------

Create a git repo:

```sh
TARGET=~/git/myvagrant_env
mkdir -p "$TARGET"
pushd "$TARGET"
git init
```

I will be using forklift as a library. For this i am going to use git subtrees. Read more about
subtress in this excellent article written by Nicola Paolucci from Atlassian: https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree

Add the forklift repo as a subdir in your current git repo:

```sh
git remote add -f theforeman-forklift https://github.com/theforeman/forklift.git

```

Create a custom ```ansible.cfg``` inside your repo with the following contents:

```ini
[defaults]
nocows = 1
host_key_checking = False
retry_files_enabled = False
roles_path = $PWD/galaxy_roles:$PWD/roles:$PWD/forklift/playbooks/roles
callback_plugins = $PWD/forklift/playbooks/callback_plugins/
inventory = forklift/playbooks/inventory/vagrant.py
```

Now create a basic folder structure which is used by forklift/ansible

```sh
mkdir playbooks
mkdir roles
mkdir pipelines
```

Create a ```base_boxes.yaml``` with the boxes you want to use. This is a sample from the forklift
docs:

```
centos7:
  box_name:   'centos/7'
  image_name: !ruby/regexp '/CentOS 7.*PV/'
  default:    true
  pty:        true
```

Now create a basic Vagrantfile which uses forklift:

```
require "#{File.dirname(__FILE__)}/forklift/lib/forklift"

loader = Forklift::BoxLoader.new
loader.add_boxes("base_boxes.yaml")
distributor = Forklift::BoxDistributor.new(loader.boxes)
distributor.distribute
```

Trying it out
-------------

Now you may go ahead and run some ```vagrant``` commands! Try to display your machines and start a
box!

TL;DR: run ```vagrant_forklift_repo.sh``` to create a basic skeleton at the provided path
