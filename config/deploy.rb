set :default_stage, "production"
set :stages, %w(production staging)
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :use_sudo, false
set :scm, :git
set :repository, "git@github.com:bowsinger/nubo.git"
set :ssh_options, {:forward_agent=>true}
set :deploy_via, :remote_cache
# default shared_children is %w(public/system log tmp/pids)
set :shared_children, fetch(:shared_children) + ['tmp/sockets', 'vendor/bundle']
set :copy_exclude, ['.git']

default_run_options[:pty] = true

namespace :deploy do
  
  desc "use environment configuration"
  task :copy_env_config, :roles => [:app, :web] do
    config_dir = rails_env unless exists?(:config_d)
    run "cp -rf #{current_release}/config.d/#{config_dir}/* #{current_release}/config/"
  end
  
  desc "add priviledge to executables"
  task :chmod_executables, :roles => [:app, :web] do
    run <<-EOS
      chmod u+x #{current_release}/script/* &&
      chmod u+x #{current_release}/lib/tasks/cb_namecheck64 &&
      chmod u+x #{current_release}/lib/surem/smscall &&
      chmod u+x #{current_release}/lib/jobs/*.sh &&
      chmod u+x #{current_release}/lib/feeds/*.sh
    EOS
  end
  task :start, :roles => :app do
    run "cd #{current_path}; script/unicorn start"
  end
  
  task :stop, :roles => :app do
    run "cd #{current_path}; script/unicorn stop"
  end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path}; script/unicorn upgrade"
  end
    
end

after "deploy:update", "deploy:copy_env_config"
after "deploy:update", "deploy:chmod_executables"
