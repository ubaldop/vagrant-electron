#!/bin/bash

if [ ! -f ~/runonce ] #here the check is on the root home directory
then
	cd /home/vagrant
	echo "Installing nvm..."
	wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
	export NVM_DIR="/home/vagrant/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		nvm install node
		npm install bower -g
		npm install electron -g

		echo ':::: setting up liquidprompt to vagrant machine ::::'

		echo "Installing liquidprompt..."
		cd /home/vagrant/
		git clone https://github.com/nojhan/liquidprompt.git
		source liquidprompt/liquidprompt

		echo "Setting up liquidprompt to the .bashrc folder"
		echo '# Only load Liquid Prompt in interactive shells, not from a script or from scp'  >> /home/vagrant/.bashrc
		echo '[[ $- = *i* ]] && source /home/vagrant/liquidprompt/liquidprompt' >> /home/vagrant/.bashrc

		touch ~/runonce	#avoid script to be provisioned more than once

	else
		echo "::: nvm already provisioned :::"
		nvm node --version
	fi	
