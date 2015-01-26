worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  
  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end

  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = ENV['REDIS_URI']
    Rails.logger.info('Connected to Redis')
  end

  Signal.trap 'TERM' do
    msg  = 'Unicorn worker intercepting TERM and doing nothing. '
    msg += 'Wait for master to send QUIT'
    puts msg
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end