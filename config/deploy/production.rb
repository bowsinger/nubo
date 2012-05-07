#role :web, "dev3.thinkreals.com", "dev4.thinkreals.com", "dev8.thinkreals.com", "dev5.thinkreals.com", "dev7.thinkreals.com", "dev79.thinkreals.com", "dev80.thinkreals.com"
#role :app, "dev3.thinkreals.com", "dev4.thinkreals.com", "dev8.thinkreals.com", "dev5.thinkreals.com", "dev7.thinkreals.com", "dev79.thinkreals.com", "dev80.thinkreals.com"
#role :web, "dev3.thinkreals.com", "dev4.thinkreals.com", "dev5.thinkreals.com", "dev79.thinkreals.com", "dev80.thinkreals.com"
#role :app, "dev3.thinkreals.com", "dev4.thinkreals.com", "dev5.thinkreals.com", "dev79.thinkreals.com", "dev80.thinkreals.com"
role :app, "dev.darammg.com"
role :web, "dev.darammg.com"
role :master_app, "dev.darammg.com"
role :db,  "dev.darammg.com", :primary => true # This is where Rails migrations will run

set :rails_env, "production"
set :application, "nubo"
set :deploy_to, "/home/darammg/deploy/#{application}"
set :branch, "master"

namespace :delayed_job do
  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end

  def args
    fetch(:delayed_job_args, "")
  end

  def roles
    fetch(:master_app)
  end

end
after "deploy:stop"
after "deploy:start"
after "deploy:restart"
after "bundle:install"
