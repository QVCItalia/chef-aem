#
# Cookbook Name:: aem
# Recipe:: author
#
# Copyright (C) 2014 Sergio Leone
#
#

include_recipe 'java'

author_install_path = "#{node['aem']['install_path']}/author"

user node['aem']['user'] do
	comment 'AEM User'
	home node['aem']['install_path']
	shell '/bin/bash'
	supports :manage_home => true
	system true
	action :create
end

directory "#{author_install_path}" do
	owner node['aem']['user']
	group node['aem']['user']
	mode 00755
	action :create
	recursive true
end

if node['aem']['license']['customer'] == nil && node['aem']['license']['downloadId'] == nil
  Chef::Application.fatal!("The license customer and downloadId can't be nil")
end

template "#{author_install_path}/license.properties" do
	source 'license.properties.erb'
	owner node['aem']['user']
	group node['aem']['user']
	mode '0755'
end

remote_file "#{author_install_path}/cp6-author-p#{node['aem']['author']['port']}.jar" do
	source node['aem']['url']
	checksum node['aem']['checksum']
	owner node['aem']['user']
	group node['aem']['user']
	mode 0755
end

execute 'aem-author-jar' do
	cwd author_install_path
	user node['aem']['user']
	group node['aem']['user']
	command "java -XX:MaxPermSize=#{node['aem']['java']['maximum_permgen']} -Xmx#{node['aem']['java']['xmx']} -jar cp6-author-p#{node['aem']['author']['port']}.jar &"
end
