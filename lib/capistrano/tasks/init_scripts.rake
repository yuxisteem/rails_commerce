namespace :init do
  task :upgrade do
    on roles(:app) do
      execute "/etc/init.d/rails_commerce upgrade"
    end
  end
end
