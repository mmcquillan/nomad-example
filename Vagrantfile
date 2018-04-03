# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "nomad"

  # port for the host
  config.vm.network "forwarded_port", guest: 4646, host: 4646, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9998, host: 9998, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9999, host: 9999, host_ip: "127.0.0.1"

  # disable logs and increase resources
  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    vb.memory = 4096
    vb.cpus = 4
  end
  #
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
  config.vm.provision "shell", inline: "cp /vagrant/systemd/consul.service /etc/systemd/system/consul.service"
  config.vm.provision "shell", inline: "systemctl daemon-reload && systemctl start consul.service"

  # Nomad
  config.vm.provision "shell", inline: "wget -q -O /tmp/nomad.zip https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip"
  config.vm.provision "shell", inline: "unzip /tmp/nomad.zip -d /usr/local/bin/"
  config.vm.provision "shell", inline: "cp /vagrant/systemd/nomad.service /etc/systemd/system/nomad.service"
  config.vm.provision "shell", inline: "systemctl daemon-reload && systemctl start nomad.service"

	# Go
  config.vm.provision "shell", inline: "wget -q -O /tmp/go.tar.gz https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz"
  config.vm.provision "shell", inline: "tar -C /usr/local -xzf /tmp/go.tar.gz"
  config.vm.provision "shell", inline: "echo 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/go.sh"
  config.vm.provision "shell", inline: "echo 'export GOPATH=/code/go' >> /home/vagrant/.profile"
  config.vm.synced_folder ENV['GOPATH'], "/code/go"

end
