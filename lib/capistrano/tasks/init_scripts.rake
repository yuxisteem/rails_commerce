namespace :init do
  desc 'Start the application services'
  task :start do
    on roles(:app) do
      invoke 'init:unicorn:upgrade'
      invoke 'init:worker:restart'
    end
  end

  desc 'Stop the application services'
  task :stop do
    on roles(:app) do
      invoke 'init:unicorn:stop'
      invoke 'init:worker:stop'
    end
  end

  desc 'Restart the application services'
  task :restart do
    on roles(:app) do
      invoke 'init:unicorn:upgrade'
      invoke 'init:worker:restart'
    end
  end

  namespace :unicorn do
    desc 'Zero downtime restart'
    task :upgrade do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce upgrade'
      end
    end

    desc 'Start Unicorn'
    task :start do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce start'
      end
    end

    desc 'Stop Unicorn'
    task :stop do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce stop'
      end
    end

    desc 'Restart Unicorn'
    task :restart do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce restart'
      end
    end
  end

  namespace :worker do
    desc 'Start background worker service'
    task :start do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce_worker start'
      end
    end

    desc 'Stop background worker service'
    task :stop do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce_worker stop'
      end
    end

    desc 'Restart background worker service'
    task :restart do
      on roles(:app) do
        execute '/etc/init.d/rails_commerce_worker restart'
      end
    end
  end
end
