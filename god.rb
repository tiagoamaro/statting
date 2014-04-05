RAILS_ROOT = "/home/rails"
RAILS_ENV = "production"

God.watch do |w|
  w.name = "rails"
  w.start = "cd #{RAILS_ROOT}; bundle exec rails s -e production -p 8080 -d"
  w.stop = "cd #{RAILS_ROOT}; bundle exec rails stop -e production"

  w.pid_file = File.join(RAILS_ROOT, "tmp/pids/server.pid")

  w.behavior(:clean_pid_file)
  w.keepalive
end

God.watch do |w|
  w.name = "delayed_job"
  w.start = "cd #{RAILS_ROOT};  RAILS_ENV=#{RAILS_ENV} bin/delayed_job start"
  w.stop = "cd #{RAILS_ROOT}; RAILS_ENV=#{RAILS_ENV} bin/delayed_job stop"
  w.log = "#{RAILS_ROOT}/log/god_delayed_job.log"
  w.pid_file = "#{RAILS_ROOT}/tmp/pids/delayed_job.pid"

  w.behavior(:clean_pid_file)
  w.keepalive
end

God.watch do |w|
  w.name = "clockwork"
  w.start = "cd #{RAILS_ROOT};  RAILS_ENV=#{RAILS_ENV} clockworkd start --log"
  w.stop = "cd #{RAILS_ROOT}; RAILS_ENV=#{RAILS_ENV} clockworkd stop"
  w.pid_file = "#{RAILS_ROOT}/tmp/clockworkd.clock.pid"

  w.behavior(:clean_pid_file)
  w.keepalive
end
