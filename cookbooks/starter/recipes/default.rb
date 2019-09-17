# This is a Chef recipe file. It can be used to specify resources which will
# apply configuration to a server.
file '/home/ubuntu/rani' do
end

include_recipe 'starter::new'
include_recipe 'starter::apache'
include_recipe 'mysl'
# For more information, see the documentation: https://docs.chef.io/essentials_cookbook_recipes.html
