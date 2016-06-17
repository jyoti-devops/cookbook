#
# Cookbook Name:: provision
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'chef/provisioning/aws_driver'

with_driver 'aws'

with_machine_options({
convergence_options:{
ssl_verify_mode: :verify_none
},
    bootstrap_options: {
    image_id: "#{node.default[:aws_provision][:image_id]}", # default for us-west-1
  
    instance_type: "#{node.default[:aws_provision][:instance_type]}",
    key_name: "#{node.default[:aws_provision][:key_name]}", # If not specified, this will be used and generated
#    key_path: "~/.chef/keys/arajdevops", # only necessary if storing keys some other location
      },
  use_private_ip_for_ssh: false, # DEPRECATED, use `transport_address_location`
  transport_address_location: :public_ip, # `:public_ip` (default), `:private_ip` or `:dns`.  Defines how SSH or WinRM should find an address to communicate with the instance.

})

 node.default[:aws_provision][:appserver][:instance_name] =  node[:aws_provision][:appserver][:instance_name]+ "_"+node[:aws_provision][:environment][:name]
  node.default[:aws_provision][:dbserver][:instance_name] =  node[:aws_provision][:dbserver][:instance_name]+ "_"+node[:aws_provision][:environment][:name]

puts  node.default[:aws_provision][:appserver][:instance_name]
environment = node[:aws_provision][:environment][:name]
puts environment

machine node.default[:aws_provision][:dbserver][:instance_name] do
  tag 'ops'
  converge true
  role node[:aws_provision][:dbserver][:role]
chef_environment environment
  # action :destroy
end


machine node.default[:aws_provision][:appserver][:instance_name] do
  tag 'ops'
  converge true
  role node[:aws_provision][:appserver][:role]
chef_environment environment
  # action :destroy
end

