# == Define: gocd::server::user

define gocd::server::user (
  $password = undef,
) {
  validate_string($name)
  validate_string($password)

  $name_regex = '^[a-z0-9_-]{3,16}$'
  $name_error = "The username '${name}' is not valid."
  validate_re($name, $name_regex, $name_error)

  $password_regex = '^[a-zA-Z0-9+\/]+={0,2}$'
  $password_error = "The password hash '${password}' is not valid."
  validate_re($password, $password_regex, $password_error)

  concat::fragment { "/var/lib/go-server/passwd:${name}":
    target  => '/var/lib/go-server/passwd',
    content => "${name}:${password}",
  }
}
