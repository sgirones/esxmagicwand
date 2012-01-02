require File.join(File.dirname(__FILE__), 'dhcp.rb')

module VMWizard

    class VirtualMachine
        attr_reader :name, :disk_size, :cpu, :ram, :disk_type, :guest, :nics

        def initialize(specs)
            @name = specs[:name]
            @disk_size = specs[:disk_size]
            @cpu = specs[:cpu]
            @ram = specs[:ram]
            @disk_type = specs[:disk_type]
            @guest = specs[:guest]
            @nics = specs[:nics]
        end
    end

    class MagicWand
        attr_reader :esx_host, :dhcp_host

        def initialize(esx_host, dhcp_host)
            @esx_host = esx_host
            @dhcp_host = dhcp_host
        end

        def deploy(vm, datastore)
            vm = @esx_host.create_vm(
                        :vm_name => vm.name, 
                        :datastore => datastore,
                        :disk_type => :thin,
                        :disk_size => vm.disk_size,
                        :memory => vm.ram,
                        :guest_id => vm.guest,
                        :nics => vm.nics
                    )

            return vm
        end

        def undeploy(vm_name)
            vm = nil
            esx_host.virtual_machines.each do |x|
                if x.name == vm_name
                    vm = x
                    break
                end
            end

            if not vm
                raise "VM with name #{vm_name} not found"
            end

            if vm.power_state == "poweredOn"
                vm.power_off
            end

            vm.destroy

        end
    end
end
