# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME_MACHINE = "electron.box"

# Setup root script
$baseScript = <<SCRIPT
		echo "I am provisioning a #{HOSTNAME_MACHINE} machine"
		cd /home/vagrant
		add-apt-repository ppa:git-core/ppa
		apt-get update
		apt-get install -y vim git curl
		echo "Installing required graphical libraries for Electron"
		apt-get install -y libgtk2.0-0
		apt-get install -y libxss1
	  apt-get install -y GConf2
		apt-get install -y libnss3
		# apt-get install -y libcanberra-gtk*
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|
	hostname = HOSTNAME_MACHINE
	locale = "en_GB.UTF.8"
	# Box
	config.vm.box = "ubuntu/trusty64"
	# Shared folders
	config.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"

	# Removes "stdin: is not a tty" annoyance as per
	# https://github.com/SocialGeeks/vagrant-openstack/commit/d3ea0695e64ea2e905a67c1b7e12d794a1a29b97
	config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

	#setup X-Forwarding
	config.ssh.forward_x11 = true

	# Provision basic tools
	config.vm.provision :shell, :inline => $baseScript
	config.vm.provision :shell, :path => "scripts/setup.sh", privileged: false

	config.vm.provider "virtualbox" do |vb|
		vb.customize	[
			"modifyvm", :id,
			'--cableconnected1', 'on',
			"--memory", 1024,
			]

		# Allow the creation of symlinks for nvm
		# http://blog.liip.ch/archive/2012/07/25/vagrant-and-node-js-quick-tip.html
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant","1"]
	end
end
