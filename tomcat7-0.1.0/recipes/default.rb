#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#


include_recipe "java"

execute 'set host file' do
	command  <<-EOF 
	echo "127.0.0.1 $(hostname)" >> /etc/hosts
	EOF
end
#install tomcat7
["tomcat7", "tomcat7-docs", "tomcat7-examples", "tomcat7-admin"].each do |pkg|
	package pkg do
		action :install
	end
end
#Download War file from nexux repositoryOA

#url= node[:tomcat7][:nexus_url]+node[:tomcat7][:war][:version]+ node[:tomcat7][:war][:name]
#puts url
remote_file "#{node[:tomcat7][:dep_dir]}/petclinic_mysql.war" do
  source "#{node[:tomcat7][:giturl]}"
# source "#{url}"
 action :create
end

#start tomcat service

service 'tomcat7' do
	supports :restart => true
	action :restart
end
environment="#{node[:tomcat7][:environment][:name]}"
puts environment
#Get the Database server details
dbserver = search(:node, 'role:"dbserver"')

puts dbserver.class

#Add database details
template "#{node[:tomcat7][:database_connection]}" do
	source 'data-access.properties.erb'
	variables(
		:dbserver => dbserver
		)
	# notifies :reload, 'service[nginx]', :immediately
end
#restart tomcat service
service 'tomcat7' do
	supports :restart => true
	action :restart
end
