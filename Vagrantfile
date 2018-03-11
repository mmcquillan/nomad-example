# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "nomad"

  # for the host
  config.vm.network "forwarded_port", guest: 4646, host: 4646
  
  # disable ubuntu's log
  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end

  # Prereqs
  config.vm.provision "shell", inline: "apt install unzip"

  # Docker
  config.vm.provision "shell", inline: "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
  config.vm.provision "shell", inline: "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\""
  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "apt-cache policy docker-ce"
  config.vm.provision "shell", inline: "sudo apt-get install -y docker-ce"

  # Consul
  config.vm.provision "shell", inline: "wget -q -O /tmp/consul.zip https://releases.hashicorp.com/consul/1.0.2/consul_1.0.2_linux_amd64.zip"
  config.vm.provision "shell", inline: "unzip /tmp/consul.zip -d /usr/local/bin/"
  config.vm.provision "shell", inline: "nohup consul agent -dev -datacenter=ExampleLand > /var/log/consul.log &"

  # Nomad
  config.vm.provision "shell", inline: "wget -q -O /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip"
  config.vm.provision "shell", inline: "unzip /tmp/nomad.zip -d /usr/local/bin/"
  config.vm.provision "shell", inline: "cp /vagrant/nomad.service /etc/systemd/system/nomad.service"
  config.vm.provision "shell", inline: "systemctl daemon-reload && systemctl start nomad.service"
  #config.vm.provision "shell", inline: "nohup nomad agent -dev -dc=ExampleLand -consul-address=127.0.0.1:8301 > /var/log/nomad.log &"

end
