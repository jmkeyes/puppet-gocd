# == Class: gocd::server::service

class gocd::server::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  service { $::gocd::server::service_name:
    ensure     => $::gocd::server::service_ensure,
    enable     => $::gocd::server::service_enable,
    hasrestart => true,
    hasstatus  => true,
  }
}
