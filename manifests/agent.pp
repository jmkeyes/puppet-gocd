# == Class: gocd::agent

class gocd::agent (
  $server,
  $package_name    = 'go-agent',
  $package_ensure  = 'installed',
  $service_name    = 'go-agent',
  $service_ensure  = 'running',
  $service_enable  = true,
  $manage_service  = true,
  $manage_package  = true,
  $server_ssl_port = 8154,
  $server_port     = 8153,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::gocd::common'
  contain '::gocd::agent::install'
  contain '::gocd::agent::config'
  contain '::gocd::agent::service'

  Class['::gocd::common'] ->
  Class['::gocd::agent::install'] ->
  Class['::gocd::agent::config'] ~>
  Class['::gocd::agent::service']
}
