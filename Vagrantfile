# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu_14_10"
  config.vm.network "private_network", ip: "192.168.33.11"
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: ".git/"
  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.memory = "1024"
  end

  config.vm.provision "itamae" do |config|
    config.sudo
    config.recipes = ['./recipe.rb']
  end
end
