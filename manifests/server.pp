# == Class: gocd::server

class gocd::server (
  $package_name    = 'go-server',
  $package_ensure  = 'installed',
  $service_name    = 'go-server',
  $service_ensure  = 'running',
  $service_enable  = true,
  $manage_service  = true,
  $manage_package  = true,
  $manage_firewall = true,
  $listen_port     = 8153,
  $listen_port_ssl = 8154,
  $ssl_certificate = undef,
  $ssl_private_key = undef,
  $ssl_ca_cert     = undef,
  $users           = {},
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::gocd::common'
  contain '::gocd::server::install'
  contain '::gocd::server::config'
  contain '::gocd::server::service'

  Class['::gocd::common'] ->
  Class['::gocd::server::install'] ->
  Class['::gocd::server::config'] ~>
  Class['::gocd::server::service']
}
