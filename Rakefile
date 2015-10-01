require 'puppetlabs_spec_helper/rake_tasks'

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  # Don't load blacksmith tasks in test.
end

task :test => [:lint, :validate, :spec]
