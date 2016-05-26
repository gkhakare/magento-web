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

apss = Array.new

(node["magento-web"]["magento-apps"]).each_with_index do |app, i|
    apss[i] = {
	  "hostname" => "ip#{app}",
	  "ipaddress" => "#{app}",
	  "port" => 80
	  
	}
  end

node.default["haproxy"]["members"] = apss

include_recipe "haproxy::default"


