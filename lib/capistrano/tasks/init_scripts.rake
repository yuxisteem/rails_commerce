namespace :init do
  task :upgrade do
    on roles(:app) do
      execute '/etc/init.d/rails_commerce upgrade'
    end
  end

  desc 'Start the application services'
  task :start do
    on roles(:app) do
      execute '/etc/init.d/rails_commerce start'
    end
  end

  desc 'Stop the application services'
  task :stop do
    on roles(:app) do
      execute '/etc/init.d/rails_commerce stop'
    end
  end

  desc 'Restart the application services'
  task :restart do
    on roles(:app) do
      execute '/etc/init.d/rails_commerce restart'
    end
  end
end
