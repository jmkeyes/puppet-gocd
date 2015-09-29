# == Class: gocd::server::config

class gocd::server::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  file { '/etc/default/go-server':
    ensure  => present,
    content => template("${module_name}/go-server.default.erb"),
    mode    => '0644',
  }

  concat { '/var/lib/go-server/passwd':
    ensure => present,
    mode   => '0600',
    force  => true,
    owner  => 'go',
    group  => 'go',
  }

  if $::gocd::server::ssl_certificate and $::gocd::server::ssl_private_key {
    # This is apparently hardcoded in application. :(
    $keystore_password = 'serverKeystorepa55w0rd'

    java_ks { 'cruise:/etc/go/keystore':
      ensure      => latest,
      certificate => $::gocd::server::ssl_certificate,
      private_key => $::gocd::server::ssl_private_key,
      password    => $keystore_password,
    }

    if $::gocd::server::ssl_ca_cert {
      java_ks { 'cruise:/etc/go/truststore':
        ensure       => latest,
        certificate  => $::gocd::server::ssl_ca_cert,
        password     => $keystore_password,
        trustcacerts => true,
      }
    }
  }

  if $::gocd::server::manage_firewall {
    firewall { '500 Allow incoming GoCD Server Dashboard connections.':
      ensure => present,
      state  => [ 'NEW' ],
      action => 'accept',
      chain  => 'INPUT',
      proto  => 'tcp',
      dport  => [
        $::gocd::server::listen_port_ssl,
        $::gocd::server::listen_port,
      ],
    }
  }
}
