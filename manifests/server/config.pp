# == Class: gocd::server::config
#
# Copyright 2016 Joshua M. Keyes <joshua.michael.keyes@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class gocd::server::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  validate_string($::gocd::server::jvm_min_memory)
  validate_string($::gocd::server::jvm_max_memory)

  validate_re($::gocd::server::jvm_min_memory, '^\d+[KkGgMm]$')
  validate_re($::gocd::server::jvm_max_memory, '^\d+[KkGgMm]$')

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
