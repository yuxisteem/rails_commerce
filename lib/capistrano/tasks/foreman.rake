namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    on roles(:app) do
      execute "cd #{fetch :deploy_to}/current && sudo foreman export -a #{fetch :application} -f #{fetch :deploy_to}/current/Procfile upstart /etc/init"
    end
  end

  desc "Start the application services"
  task :start do
    on roles(:app) do
      sudo "start #{fetch :application}"
    end
  end

  desc "Stop the application services"
  task :stop do
    on roles(:app) do
      sudo "stop #{fetch :application}"
    end
  end

  desc "Restart the application services"
  task :restart do
    on roles(:app) do
      execute "sudo start #{fetch :application} || sudo restart #{fetch :application}"
    end
  end
end