# == Class: gocd::common

class gocd::common (
  $manage_dependencies = true,
  $manage_repository   = true,
  $manage_user         = true,
) {
  validate_bool($manage_dependencies)
  validate_bool($manage_repository)
  validate_bool($manage_user)

  if $manage_dependencies {
    contain '::gocd::common::dependencies'
  }

  if $manage_repository {
    contain '::gocd::common::repository'
  }

  if $manage_user {
    contain '::gocd::common::user'
  }
}
