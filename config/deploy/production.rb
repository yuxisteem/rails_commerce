server '188.226.151.177', roles: %w(web app db),
                          ssh_options:
                            {
                              user: 'ubuntu',
                              forward_agent: true,
                              auth_methods: %w(publickey)
                            }

set :ssh_options, forward_agent: true
