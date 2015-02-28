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
