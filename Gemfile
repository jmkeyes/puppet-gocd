source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :rake, :development do
  gem 'rake', '~> 10.4.0', :require => false
  gem 'puppet-syntax',     :require => false
  gem 'puppet-blacksmith', :require => false
end

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 3.7.0', :require => false
end
