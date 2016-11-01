#!/bin/bash
sudo apt-get install --assume-yes puppet
cd "$(dirname ${BASH_SOURCE[0]})"
puppet module install --modulepath=./modules puppetlabs-mysql
sudo puppet apply --verbose --debug --modulepath=./modules main.pp