$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_type, :user  # Don't use system-wide RVM

# be sure to change these
default_run_options[:pty] = true

set :user, 'darmmg'
set :domain, 'nu-bo.com'
set :application, 'nu-bo'
# file paths
set :repository, "svn://vps108.narru.net:40037/nubo/trunk"
set :deploy_to, "/home/darammg/deploy/#{application}"
# distribute your applications across servers (the instructions below put them
# all on the same server, defined above as 'domain', adjust as necessary)
role :app, domain
role :web, domain
role :db, domain, :primary => true

# miscellaneous options
set :use_sudo, false
set :scm, 'subversion'

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

namespace :deploy do
  task :restart do
    #run "ln -s #{deploy_to}/#{shared_dir}/public/images/ #{current_release}/assets/images/photos/", {:roles => :app}
    run "cd #{current_release}; RAILS_ENV=production bundle exec rake assets:precompile"
    if remote_file_exists?("#{current_release}/tmp/pids/unicorn.pid")
      run "kill -USR2 `cat #{current_release}/tmp/pids/unicorn.pid`"
    else
      run "cd #{current_path} && bundle exec unicorn -c #{current_path}/config/unicorn.rb -E #{fetch(:rails_env, "production")} -D"
    end  
  end
end

namespace :bundler do
  task :symlink_bundled_gems, :roles => :app do
    run "ln -nfs #{shared_path}/bundle #{release_path}/vendor/bundle"
  end
end

after 'deploy:update_code', 'bundler:symlink_bundled_gems'

