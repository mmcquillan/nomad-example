# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "nomad"
  config.vm.network "forwarded_port", guest: 4646, host: 4646
  config.vm.provision "shell", inline: "apt install unzip"
  config.vm.provision "shell", inline: "wget -q -O /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip"
  config.vm.provision "shell", inline: "unzip /tmp/nomad.zip -d /usr/local/bin/"
  config.vm.provision "shell", inline: "nohup nomad agent -dev > /var/log/nomad.log &"
end
