RAILS_ROOT = "/home/rails"

God.watch do |w|
  w.name = "rails"
  w.start = "cd #{RAILS_ROOT}; bundle exec rails s -e production -p 8080 -d"
  w.stop = "cd #{RAILS_ROOT}; bundle exec rails stop -e production"

  w.pid_file = File.join(RAILS_ROOT, "tmp/pids/server.pid")

  w.behavior(:clean_pid_file)
  w.keepalive
end
