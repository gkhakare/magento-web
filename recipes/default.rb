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

apps = Array.new

(node["magento-web"]["magento-apps"]).each_with_index do |app, i|
    apps[i] = "ip#{app} #{app}:80"
  end

puts apps
node.default["haproxy"]["members"] = apps

include_recipe "haproxy::default" 

