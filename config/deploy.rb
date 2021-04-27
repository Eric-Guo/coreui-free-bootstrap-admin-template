# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'coreui4_demo'
set :repo_url, 'https://github.com/Eric-Guo/coreui-free-bootstrap-admin-template'
set :branch, 'cn_site'

# Default deploy_to directory is /var/www/redwoodjs_web
# set :deploy_to, "/var/www/redwoodjs_web"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# https://github.com/seuros/capistrano-sidekiq#known-issues-with-capistrano-3
set :pty, false

# Default value for :linked_files is []
append :linked_files, *%w[]

# Default value for linked_dirs is []
append :linked_dirs, 'node_modules'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  task :yarn_deploy do
    on roles fetch(:yarn_roles) do
      within fetch(:yarn_target_path, release_path) do
        execute fetch(:yarn_bin), 'install'
        execute fetch(:yarn_bin), 'run build'
      end
    end
  end

  before 'symlink:release', :yarn_deploy
end
