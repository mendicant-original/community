require 'fileutils'
require 'securerandom'

desc 'Setup project for development / deploy'
task :setup do

  # Setup config files
  database     = File.join(Rails.root, 'config', 'database.yml')
  secret_token = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')
  omniauth     = File.join(Rails.root, 'config', 'initializers', 'omniauth.rb')
  university_web      = File.join(Rails.root, 'config', 'initializers', 'university_web.rb')

  unless File.exists?(database)
    FileUtils.cp(database + '.example', database)
    puts "Database config file created"
    `$EDITOR #{database}`
  end

  unless File.exists?(secret_token)
    secret   = SecureRandom.hex(64)
    template = ERB.new(File.read(secret_token + '.erb'))

    File.open(secret_token, 'w') {|f| f.write(template.result(binding)) }
    puts "Secret Token Generated"
  end

  unless File.exists?(omniauth)
    FileUtils.cp(omniauth + '.example', omniauth)
    puts "Omniauth config file created"
    `$EDITOR #{omniauth}`
  end

  unless File.exists?(university_web)
    FileUtils.cp(university_web + '.example', university_web)
    puts "University-web config file created"
    `$EDITOR #{university_web}`
  end

  puts "Config files created"

  # Setup the database
  Rake::Task["db:create"].invoke
  Rake::Task["db:schema:load"].invoke
  Rake::Task["db:test:prepare"].invoke

  puts "Database prepared"

  # Setup seed data
  Rake::Task["db:seed"].invoke

  puts "Seed data loaded"

  # Run the tests
  Rake::Task["test"].invoke

  puts "--- Setup Complete ---"

end
