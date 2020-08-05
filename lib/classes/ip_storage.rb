require 'faker'

class IpStorage
  IP_COUNT = 50

  def self.ip_array
    @storaged_ip_adresses ||= create_ip_addreses
  end

  def self.create_ip_addreses
    ip_addresses = []

    IP_COUNT.times do
      new_ip = nil

      loop do
        new_ip = Faker::Internet.ip_v4_address
        is_duplicate = ip_addresses.include?(new_ip)
        break if !is_duplicate
      end

      ip_addresses << new_ip
    end
    
    ip_addresses
  end
end