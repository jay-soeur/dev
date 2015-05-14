dirPuppet = "/Users/jaysoeur/dev"
hostName = "www.drazzic.dev"

Vagrant.configure("2") do |config|

    # Setup the base virtual machine box name and box origin
    config.vm.box = "peakweb-centos-6.3-64bit-base-20150511"
    config.vm.box_url = "https://s3.amazonaws.com/peak-web-resources/vagrant/peakweb-centos-6.3-64bit-puppet-vbox.4.2.4-20150511.box"

    # Assign this VM a public (or bridged) network adapter, allowing anyone to
    # connect to it on the same network as the host. An IP address will be
    # assigned via DHCP and can be determined using `vagrant ssh` and then
    # `ifconfig`. 
    #config.vm.network :public_network

    # Assign this VM a host-only network adapter, allowing you to access it via
    # the specified IP. Host-only networks can talk to the host machine as well
    # as any other machines on the same network, but cannot be accessed by other
    # machines or devices on the host's external network. 
    config.vm.network :private_network, ip: "192.168.2.10"

    # Forward a port from the guest to the host, which allows for outside
    # computers to access the VM, whereas host only networking does not.
    # The final :auto_correct parameter set to true tells Vagrant to auto 
    # correct any collisions. During a vagrant up or vagrant reload, Vagrant 
    # will output information about any collisions detections and auto 
    # corrections made, so you can take notice and act accordingly. 
    #config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

    config.vm.hostname = "#{hostName}"

    config.vm.provider :virtualbox do |vbox| 
        # Boot Virtualbox VM with a GUI
        vbox.gui = false

        # Give the Virtualbox entry a name
        vbox.name = "#{hostName}"

        # VBoxManage modifyvm
        # @see http://www.virtualbox.org/manual/ch08.html
        # 
        # Allow the Guest to have this much RAM
        vbox.customize ["modifyvm", :id, "--memory", "3072"]

        # Share this much of the RAM allocation with other Guest VMs
        #vbox.customize ["modifyvm", :id, "--guestmemoryballoon", "1024"]

        # Allow the Guest access to this many CPU cores
        vbox.customize ["modifyvm", :id, "--cpus", "4"]

        # Cap the CPU utilization of the Guest on the Host
        vbox.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]

        # Enables the use of hardware virtualization extensions (Intel VT-x) 
        # @see http://ark.intel.com/Products/VirtualizationTechnology
        vbox.customize ["modifyvm", :id, "--hwvirtex", "on"]

        # Disable USB to prevent certain power on bugs in Linux VirtualBox
        vbox.customize ["modifyvm", :id, "--usb", "off"]
        vbox.customize ["modifyvm", :id, "--usbehci", "off"]

    end

    #config.vm.synced_folder dirSSHKey, "/var/tmp/vagrant/ssh",
    #    :create => true, :mount_options => [ 'dmode=700,fmode=600' ]

    # Enable provisioning with Puppet stand alone. 
    config.vm.provision :puppet do |puppet|

        puppet.manifests_path = "#{dirPuppet}/manifests"

        puppet.module_path = "#{dirPuppet}/modules"

        puppet.manifest_file = "node.pp"

        puppet.options = [ 
            '--verbose', 
            #'--debug', 
        ] 

    end

end