# == Define: gocd::server::plugin

define gocd::server::plugin (
  $source,
) {
  validate_string($name)
  validate_string($source)

  $name_regex = '^[a-z0-9_-]{3,32}$'
  $name_error = "The plugin name '${name}' is not valid."
  validate_re($name, $name_regex, $name_error)

  archive { "/var/lib/go-server/plugins/external/${name}.jar":
    ensure  => present,
    source  => $source,
    extract => false,
  } ->

  file { "/var/lib/go-server/plugins/external/${name}.jar":
    ensure => present,
    notify => Service[$::gocd::server::service_name],
    mode   => '0644',
    owner  => 'go',
    group  => 'go',
  }
}
