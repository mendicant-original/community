# Make sure +bundle exec+ is used when executing rake tasks

job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task --silent :output"

every 1.hour do
  rake "twitter:post"
end