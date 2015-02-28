require './models'



#Clean out db for tests
User.all.destroy
Group.all.destroy
Location.all.destroy
Subnet.all.destroy
IpAddress.all.destroy

#Groups
p Group.count == 0
#testing group create
admin = Group.create({
                      :name => "admin",
                      :description => "Admin group"
  })
p Group.count == 1
operator = Group.create({
                      :name => "operator",
                      :description => "Operators group"
  })
p Group.count == 2

#Users
p User.count == 0
#testing user create
mad_max = admin.users.create({
                       :name => "Mad Max",
                       :username => "mmax",
                       :password => "password"
                     })
p User.count == 1

walker = operator.users.create({
                       :name => "Captain Walker",
                       :username => "walker",
                       :password => "password"
                     })
p User.count == 2

p admin.name == "admin"
p operator.name == "operator"

p mad_max.name == "Mad Max"
p mad_max.password == "password"

#test location
p Location.count == 0
#testing location create
barter_town = Location.create({
                              :name => "Barter Town",
                              :description => "Barter town using methol energy",
                              :energy => 1000
                             })
p Location.count == 1

#Testing subnet
p Subnet.count == 0

rfc_1918 = barter_town.subnets.create({
                          :name => "pig farm",
                          :network => "192.168.0.1/24",
                          :description => "Underground pig farm run by master blaster"
                         })

p Subnet.count == 1

p IpAddress.count == 0

gw = rfc_1918.ip_addresses.create({
                          :name => "default gw",
                          :address => "192.168.0.1",
                          :dns_name => "abc_gw1",
                          :status => "UP",
                          :comments => "default gw for underground pig farm"
                         })

p IpAddress.count == 1
p barter_town.subnets.all
