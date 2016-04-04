#
# Cookbook Name:: docker-swarm-cookbook
# Recipe:: default
#
# Copyright (C) 2016 Rodrigo Reis
#
# All rights reserved - Do Not Redistribute
#

WORKSPACE = "/data"
USERNAME  = node['current_user']

case node['platform']
  when 'debian', 'ubuntu'
    execute "apt-get-update" do
      command "apt-get update --fix-missing"
      ignore_failure true
    end

    package "htop" do
      package_name 'htop'
      action :install
    end

  when 'redhat', 'centos', 'fedora'
    execute "yum-update" do
      command "yum update"
      ignore_failure true
    end
end

paths = %W(#{WORKSPACE} #{WORKSPACE}/chef)

paths.each do |path|
  directory path do
    owner USERNAME
    group USERNAME
    mode '755'
  end
end


package 'curl'

bash "Install docker-compose" do
  code <<-EOH
  curl -L #{node['docker-compose']['base_url']}/#{node['docker-compose']['version']}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  EOH
  not_if "docker-compose --version | grep -w 'docker-compose version: #{node['docker-compose']['version']}'"
end

ENV['SWARM_TOKEN'] = node.default['SWARM_TOKEN']