require 'data_mapper'
require 'bcrypt'

#Debug if needed
# DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite:development.db')

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :username, String, :required => true, :unique => true
  property :password, BCryptHash, :required => true
  property :created_at, DateTime

  belongs_to :group

end

class Group
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :unique => true
  property :description, Text
  property :created_at, DateTime

  has n, :users

end

class Location
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :unique => true
  property :energy, Integer
  property :description, Text
  property :created_at, DateTime

  has n, :subnets
end

class Subnet
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true, :unique => true
  property :network, String, :required => true, :unique => true
  property :description, Text
  property :created_at, DateTime

  belongs_to :location
  has n, :ip_addresses
end

class IpAddress
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :address, String, :required => true
  property :dns_name, String
  property :status, String
  property :comments, Text
  property :probe, String
  property :last_seen, DateTime
  property :created_at, DateTime

  belongs_to :subnet
end


DataMapper.finalize
#DataMapper.auto_migrate!
DataMapper.auto_upgrade!
#note new and save appeared cleaner with classes that had multiple associations
