# == Class: gocd::server::install

class gocd::server::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  package { $::gocd::server::package_name:
    ensure  => $::gocd::server::package_ensure,
    require => [
      Class['::gocd::common::dependencies'],
      Class['::gocd::common::repository'],
    ]
  }
}
