#
# Cookbook Name:: magento-web
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "sudo apt-get update -y"
  ignore_failure true
  action :run
end

include_recipe "haproxy::install_package"

haproxy_lb 'magento' do
  bind '0.0.0.0:80'
  mode 'tcp'
  servers (node["magento-web"]["magento-servers"]).map do |i|
    "rmq#{i} #{i}:80 check inter 10s rise 2 fall 3"
  end
  params({
    'maxconn' => 20000,
    'balance' => 'roundrobin'
  })
end
