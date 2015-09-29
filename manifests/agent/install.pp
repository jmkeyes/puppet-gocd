# == Class: gocd::agent::install

class gocd::agent::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  package { $::gocd::agent::package_name:
    ensure  => $::gocd::agent::package_ensure,
    require => [
      Class['::gocd::common::dependencies'],
      Class['::gocd::common::repository'],
    ]
  }
}
