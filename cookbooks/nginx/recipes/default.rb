#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'update'

package 'nginx' do
	action :install
	only_if { node.chef_environment == "Dev" || node.chef_environment == "uat" || node.chef_environment == "prod" }
end

service 'nginx' do 
	action [ :enable, :start ]
	only_if { node.chef_environment == "Dev" || node.chef_environment == "uat" || node.chef_environment == "prod"  }
end

cookbook_file '/usr/share/nginx/html/index.html' do
  source 'dev'
  only_if { node.chef_environment == "Dev" }
end

cookbook_file '/var/www/html/index.nginx-debian.html' do
  source 'uat'
  only_if { node.chef_environment == "uat" }
end

cookbook_file '/var/www/html/index.nginx-debian.html' do
  source 'prod'
  only_if { node.chef_environment == "prod" }
end

file '/tmp/test' do
end


bash 'john' do
    cwd '/tmp'
    code <<-EOH
    useradd wesley  
    echo "This is the new file" >>  /tmp/test
    EOH
    only_if { ::File.exist?('/tmp/test') }
    not_if "cat /tmp/test | grep 'file' "
    notifies :run, 'bash[copy]', :immediately
end


bash 'copy' do 
     code <<-EOH
     cp /tmp/test /var/www/html/index.nginx-debian.html
     EOH
     only_if { node.chef_environment == "prod" }
     action :nothing
end


cron 'kumar' do
  minute '*'
  command 'chef-client'
 end
