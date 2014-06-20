#
# Cookbook Name:: aem
# Recipe:: publish
#
# Copyright (C) 2014 Sergio Leone
#
#

include_recipe 'java'

publish_install_path = "#{node['aem']['install_path']}/publish"

user node['aem']['user'] do
	comment 'AEM User'
	home node['aem']['install_path']
	shell '/bin/bash'
	supports :manage_home => true
	system true
	action :create
end

directory "#{publish_install_path}" do
	owner node['aem']['user']
	group node['aem']['user']
	mode 00755
	action :create
	recursive true
end

if node['aem']['license']['customer'] == nil && node['aem']['license']['downloadId'] == nil
  Chef::Application.fatal!("The license customer and downloadId can't be nil")
end

template "#{publish_install_path}/license.properties" do
	source 'license.properties.erb'
	owner node['aem']['user']
	group node['aem']['user']
	mode '0755'
end

remote_file "#{publish_install_path}/cp6-publish-p#{node['aem']['publish']['port']}.jar" do
	source node['aem']['url']
	checksum node['aem']['checksum']
	owner node['aem']['user']
	group node['aem']['user']
	mode 0755
end

execute 'aem-publish-jar' do
	cwd publish_install_path
	user node['aem']['user']
	group node['aem']['user']
	command "java -XX:MaxPermSize=#{node['aem']['java']['maximum_permgen']} -Xmx#{node['aem']['java']['xmx']} -jar cp6-publish-p#{node['aem']['publish']['port']}.jar &"
end
