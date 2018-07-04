# frozen_string_literal: true

@app_path = '/var/apps/jotaay/current'

worker_processes 6
working_directory "#{@app_path}/"

listen  "#{@app_path}/tmp/sockets/unicorn.sock"
pid     "#{@app_path}/tmp/pids/unicorn.pid"

stderr_path "#{@app_path}/log/unicorn.stderr.log"
stdout_path "#{@app_path}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && (GC.copy_on_write_friendly = true)

before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = @app_path + '/Gemfile'
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    begin
      if defined?(Octopus) && Octopus.enabled?
        ActiveRecord::Base.connection_proxy.clear_all_connections!
      else
        ActiveRecord::Base.connection.disconnect!
      end
    rescue ActiveRecord::ConnectionNotEstablished
      nil
    end
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  unless old_pid == server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill sig, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |_server, _worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection_proxy.initialize_shards(Octopus.config) if defined?(Octopus) && Octopus.enabled?
  end
end
