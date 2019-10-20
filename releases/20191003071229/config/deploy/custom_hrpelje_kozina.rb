set :deploy_to, deploysecret(:deploy_to)
set :server_name, deploysecret(:server_name)
set :db_server, deploysecret(:db_server)
set :branch, :consuless
set :ssh_options, port: deploysecret(:ssh_port)
set :stage, :production
set :rails_env, :production
set :repo_url, deploysecret(:repo_url)

server deploysecret(:server1), user: deploysecret(:user), roles: %w(web app db importer cron background)
