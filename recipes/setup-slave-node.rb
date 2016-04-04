#
# Cookbook Name:: docker-swarm-cookbook
# Recipe:: setup-slave-node
#
# Copyright (C) 2016 Rodrigo Reis
#
# All rights reserved - Do Not Redistribute
#

WORKSPACE = '/data/swarm-slave'
USERNAME = node['current_user']
caroot = node.default['CA_ROOT']

paths = %W(#{WORKSPACE})

paths.each do |path|
  directory path do
    owner USERNAME
    group USERNAME
    mode '755'
  end
end

files = %W(ca.pem server.pem server-key.pem cert.pem key.pem)
files.each do |filename|
  cookbook_file "#{caroot}/#{filename}" do
    source "certs/#{filename}"
    owner USERNAME
    group USERNAME
    mode  '0600'
    action :create
  end
end

################
# Docker service
################

docker_service 'default' do
  host ['unix:///var/run/docker.sock', 'tcp://0.0.0.0:2376']
  version node.default[:deploy]['version']
  labels ['environment:test', 'foo:bar']
  tls_verify true
  tls_ca_cert "#{caroot}/ca.pem"
  tls_server_cert "#{caroot}/server.pem"
  tls_server_key "#{caroot}/server-key.pem"
  tls_client_cert "#{caroot}/cert.pem"
  tls_client_key "#{caroot}/key.pem"
  install_method 'package'
  action [:create, :start]
end

# Add user to docker group
fix_user_permission "fix_user_permission slave node" do
  username node['current_user']
end

cookbook_file "#{WORKSPACE}/docker-compose.yml" do
  source 'setup-master-node/docker-compose.yml'
  owner USERNAME
  group USERNAME
  mode  '0600'
  action :create
end

# TODO: fix it.
ENV['MASTER_IP_ADDRESS'] = '10.0.2.15'
# ENV['NODE_IP_ADDRESS'] =
ENV['CA_ROOT'] = caroot

log "IP SLAVE: #{node["ipaddress"]}"