# Docker Compose default values
default['docker-compose']['config_directory'] = '/etc/compose.d'
default['docker-compose']['version'] = '1.5.1'
default['docker-compose']['include_docker'] = false
default['docker-compose']['base_url'] = 'https://github.com/docker/compose/releases/download'
# SWARM
default['SWARM_TOKEN']='d033e1b6ac4999a5bf2553d7fd9aeefc'
# Docker default version
default[:deploy]['version']='1.10.3'
# CA
default['CA_NAME'] = 'certs'
default['CA_ROOT'] = '/data/certs'