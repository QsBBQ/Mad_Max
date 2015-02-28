require './models'
require 'faker'
require 'ipaddress'

#note to self getting
#The source must be saved before creating a resource (DataMapper::UnsavedParentError)
#I think everything is still working but some parent child is having issues maybe
#Clean out db for tests
User.all.destroy
Group.all.destroy
Location.all.destroy
Subnet.all.destroy
IpAddress.all.destroy


#Seeding groups and users
admin = Group.create({
                      :name => "admin",
                      :description => "Admin group"
                    })
operator = Group.create({
                         :name => "operator",
                         :description => "Operators group"
                       })

mad_max = admin.users.create({
                              :name => "Mad Max",
                              :username => "mmax",
                              :password => "password"
                            })
walker = operator.users.create({
                                :name => "Captain Walker",
                                :username => "walker",
                                :password => "password"
                              })
10.times do
  user = operator.users.create({
                                :name => Faker::Name.name ,
                                :username => Faker::Internet.user_name,
                                :password => Faker::Internet.password
                                })
end

#seeding location
barter_town = Location.create({
                              :name => "Barter Town",
                              :description => "Barter town using methol energy",
                              :energy => 1000
                             })

first_counter = 0
first_subnet = "192.168.0.0/24"
first_subnet_split = first_subnet.split(".")
10.times do
  location = Location.create({
                              :name => Faker::Address.city,
                              :description => Faker::Lorem.paragraph(1),
                              :energy => Faker::Number.number(4)
                            })
  new_subnet = first_subnet_split[0] + "." + first_subnet_split[1] + "." + first_counter.to_s + "." + first_subnet_split[3]
  first_counter += 1
  #seeding subnets

  subnet = location.subnets.create({
                                    :name => Faker::Commerce.department,
                                    :network => new_subnet,
                                    :description => Faker::Lorem.paragraph(1)

                                    })

  #Seed ips in subnets
  ip = IPAddress new_subnet
  ip.each_host do |host|
    subnet.ip_addresses.create({
                              :name => Faker::Internet.domain_word,
                              :address => host.address,
                              :dns_name => Faker::Internet.domain_name,
                              :status => "UP",
                              :comments => Faker::Company.bs
                             })
  end
end
