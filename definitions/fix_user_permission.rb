define :fix_user_permission, :username => '' do
  Chef::Log.info("********** Adding user #{params[:username]} to docker group **********")
  # Todo: remove this log line
  log "********** Configure Nginx: #{params[:path]} #{params[:conf_file]} #{params[:ssl_file]} **********"

  group 'docker' do
    action :modify
    members [params[:username]]
    append true
  end

  username_list = %w[vagrant ubuntu ec2-user admin]
  username_list.each do |user|
    if node['etc']['passwd'][user]
      group 'docker' do
        action :modify
        members [user]
        append true
      end
    end
  end

end