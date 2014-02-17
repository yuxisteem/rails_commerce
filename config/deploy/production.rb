server '188.226.141.131', roles: %w{web app db}, ssh_options: {user: 'rails', forward_agent: true, auth_methods: %w(publickey)}

set :ssh_options, {forward_agent: true}
set :rails_env, 'production'
