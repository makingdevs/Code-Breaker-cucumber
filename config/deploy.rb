# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :passenger_roles => %{web app}
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 5
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, false
set :passenger_environment_variables, {}
set :passenger_restart_command, 'passenger-config restart-app'
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }
set :application, "code_breaker"
set :repo_url, "git@github.com:makingdevs/Code-Breaker-cucumber.git"
set :deploy_to, "/home/ec2-user/code_breaker"
set :ssh_options, { :forward_agent => true }
set :default_env, { path: "~/.asdf/shims:~/.asdf/bin:$PATH" }


set :passenger_restart_command, 'passenger:restart'

namespace :deploy do
  task :start_passenger do
    on roles(:all) do
      if test("[ -f #{deploy_to}/passenger.4567.pid.lock ]")
      	execute "cd #{deploy_to}/current && bundle exec passenger restart -p 4567 --environment staging --daemonize"
      else
        execute "cd #{deploy_to}/current && bundle exec passenger start -p 4567 --environment staging --daemonize"
      info "Hector no no es gei"
      end
    end
  end
end

after 'deploy:log_revision', 'deploy:start_passenger'


# namespace :deploy do
#   task :restart do
#     on roles(:web) do
#       invoke fetch(:passenger_restart_command)
#     end
#   end
#   after :publishing, :restart
# end

# namespace :deploy do  
#   task :make_files do
#     on roles(:all) do
#       execute :touch, "#{current_path}/jalahdtpm.md"      
#     end
#   end  
# end

# namespace :deploy do  
#   task :write_files do
#     on roles(:all) do
#       execute "echo 'Erick es gei' >> #{current_path}/jalahdtpm.md"      
#     end
#   end  
# end


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
