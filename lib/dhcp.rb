module DHCP

    class Server
        attr_reader :address, :port

        def initialize(address, port)
            @address = address
            @port = port
        end

        def add_lease(lease)
            File.open('/tmp/add_pxe_lease','w') do |file|
                file.puts "server #{@address}"
                file.puts "server #{@port}"
                file.puts "connect"
                file.puts "new host"
                file.puts "set name = \"#{lease.name}\""
                file.puts "set hardware-address = #{lease.mac}"
                file.puts "set hardware-type = 1"
                file.puts "set ip-address = #{lease.ip}"
                file.puts "set statements = \"#{lease.statements_string}\""
                file.puts "create"
            end

            #execute!
            `cat /tmp/add_pxe_lease | omshell`
            `rm /tmp/add_pxe_lease`
        end

        def del_lease(lease)
            File.open('/tmp/del_pxe_lease','w') do |file|
                file.puts "server #{address}"
                file.puts "server #{port}"
                file.puts "connect"
                file.puts "new host"
                file.puts "set name = \"#{lease.name}\""
                file.puts "open"
                file.puts "remove"
            end

            #execute!
            `cat /tmp/del_pxe_lease | omshell`
            `rm /tmp/del_pxe_lease`
        end
    end

    class Lease
        attr_reader :name, :ip, :mask , :mac, :pxe_path, :hostname

        def initialize(definition)
            @name = definition[:name]
            @ip = definition[:ip]
            @mask = definition[:mask]
            @mac = definition[:mac]
            @pxe_path = definition[:pxe_path] if definition.include? :pxe_path
            @hostname = definition[:hostname] if definition.include? :hostname
        end

        def statements_string
            out = "option subnet-mask = #{ip2hex(@mask)};"
            if @pxe_path
                out += " filename = \\\"#{@pxe_path}\\\";"
            end
            if @hostname
                out += " host-name = \\\"#{@hostname}\\\";"
            end
            return out
        end

        def ip2hex ip
          ip.split(".").map{|i| "%02x" % i }.join(":")
        end
    end

end





