# == Define: gocd::server::plugin

define gocd::server::plugin (
  $url,
) {

  # wget from https://github.com/maestrodev/puppet-wget
  include wget

  validate_string($name)
  validate_string($url)

  $name_regex = '^[a-z0-9_-]{3,32}$'
  $name_error = "The plugin name '${name}' is not valid."


  validate_re($name, $name_regex, $name_error)

  $download_dir = '/tmp'


  $tmpzip = "${download_dir}/${name}.zip"

  wget::fetch { "s3-plugin-dl-${name}":
        source      => $url,
        destination => $tmpzip,
  }  ->
  file { $name:
    ensure => file,
    path   => "/var/lib/go-server/plugins/external/${name}.jar",
    source => $tmpzip,
    notify => Service[$::gocd::server::service_name],
  }
}
