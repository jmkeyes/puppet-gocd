# == Class: gocd::agent
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

class gocd::agent (
  $server,
  $package_name    = 'go-agent',
  $package_ensure  = 'installed',
  $service_name    = 'go-agent',
  $service_ensure  = 'running',
  $service_enable  = true,
  $manage_service  = true,
  $manage_package  = true,
  $server_ssl_port = 8154,
  $server_port     = 8153,
  $jvm_min_memory  = undef,
  $jvm_max_memory  = undef,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::gocd::common'
  contain '::gocd::agent::install'
  contain '::gocd::agent::config'
  contain '::gocd::agent::service'

  Class['::gocd::common'] ->
  Class['::gocd::agent::install'] ->
  Class['::gocd::agent::config'] ~>
  Class['::gocd::agent::service']
}
