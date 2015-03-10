require 'sinatra'
require './models'

helpers do
  def get_ip
    ip = request.ip
  end
end
get "/" do
  "Test"
end

get "/ipam" do
  get_ip
  locations = Location.all


  erb :ipam_display, :locals => {:client_ip => get_ip,
                                 :locations => locations,
                                 }
end

put "/ipam/save" do
  #params.inspect
  params["ipam"].each do |id, form_values|
    ip_id = id
    ip_address = IpAddress.get(ip_id)
    ip_address.status = form_values["status"]
    ip_address.comments = form_values["comments"]
    ip_address.save
  end
  redirect "/ipam"
end

get "/ipam/edit" do
  "Test"
end

post "/ipam/edit" do
end

get "/ipam/:subnet_id" do
  get_ip
  subnet_id = params[:subnet_id]
  subnet = Subnet.get(subnet_id)

  erb :ipam_subnet, :locals => {:client_ip => get_ip,
                                :subnet => subnet
                                }
end
