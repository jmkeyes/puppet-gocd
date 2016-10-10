# == Class: gocd::agent::config
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

class gocd::agent::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  validate_string($::gocd::agent::jvm_min_memory)
  validate_string($::gocd::agent::jvm_max_memory)

  validate_re($::gocd::agent::jvm_min_memory, '^\d+[KkGgMm]$')
  validate_re($::gocd::agent::jvm_max_memory, '^\d+[KkGgMm]$')

  file { '/etc/default/go-agent':
    ensure  => present,
    content => template("${module_name}/go-agent.default.erb"),
    mode    => '0644',
    owner   => 'go',
    group   => 'go',
  }
}
