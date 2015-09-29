# == Class: gocd::agent::service

class gocd::agent::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  service { $::gocd::agent::service_name:
    ensure     => $::gocd::agent::service_ensure,
    enable     => $::gocd::agent::service_enable,
    hasrestart => true,
    hasstatus  => true,
  }
}
