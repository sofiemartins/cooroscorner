worker_processes 2
working_directory "/home/pi/cooroscorner"

preload_app true

timeout 300 # seconds, this is high!

listen "/home/pi/cooroscorner/var/sockets/cooroscorner.sock", :backlog => 64

pid "/home/pi/cooroscorner/tmp/pids/unicorn.pid"

stderr_path "/home/pi/cooroscorner/log/unicorn_errors.log"
stdout_path "/home/pi/cooroscorner/log/unicorn_out.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActionRecord::Base) and
    ActiveRecord::Base.establish_connection
end

