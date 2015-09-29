# == Class: gocd::agent::config

class gocd::agent::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  file { '/etc/default/go-agent':
    ensure  => present,
    content => template("${module_name}/go-agent.default.erb"),
    mode    => '0644',
    owner   => 'go',
    group   => 'go',
  }
}
