# == Class: gocd::server
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

class gocd::server (
  $package_name    = 'go-server',
  $package_ensure  = 'installed',
  $service_name    = 'go-server',
  $service_ensure  = 'running',
  $service_enable  = true,
  $manage_service  = true,
  $manage_package  = true,
  $manage_firewall = true,
  $listen_port     = 8153,
  $listen_port_ssl = 8154,
  $jvm_min_memory  = undef,
  $jvm_max_memory  = undef,
  $ssl_certificate = undef,
  $ssl_private_key = undef,
  $ssl_ca_cert     = undef,
  $users           = {},
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::gocd::common'
  contain '::gocd::server::install'
  contain '::gocd::server::config'
  contain '::gocd::server::service'

  Class['::gocd::common'] ->
  Class['::gocd::server::install'] ->
  Class['::gocd::server::config'] ~>
  Class['::gocd::server::service']
}
