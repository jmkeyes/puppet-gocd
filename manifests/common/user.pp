# == Class: gocd::common::user
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

class gocd::common::user (
  $user    = 'go',
  $group   = 'go',
  $home    = '/var/go',
  $comment = 'GoCD User',
) {
  if $::gocd::common::manage_daemon_user {
    user { $user:
      ensure  => present,
      comment => $comment,
      home    => $home,
      system  => true,
    } ->

    file { $home:
      ensure => directory,
      mode   => '0755',
      owner  => $user,
      group  => $group,
    }
  }
}
