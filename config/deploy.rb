# config valid only for Capistrano 3.1
lock '3.4.0'

# application settings
set :application, 'cooroscorner.com'
set :deploy_via, :copy

# repository settings
set :scm, :git
set :repo_url, 'git@github.com:sofiemartins/cooroscorner.git'
set :branch, 'master'

# server settings
set :deploy_user, 'web45'
set :deploy_to, '/html/rails'
set :use_sudo, false
set :rails_env, "production"
set :ssh_options, { :port => 981 }
set :keep_releases, 5

set :linked_files, %w{config/database.yml}
set :linkes_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :pty, true
server 'server5.railshosting.de', :app, :web, :db, :primary => true

namespace :deploy do

  before :deploy, "deploy:run_tests"
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
