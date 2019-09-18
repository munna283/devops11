#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package 'nginx' do


	action :install

 only_if { node.chef_environment=="_defalut" }
end
