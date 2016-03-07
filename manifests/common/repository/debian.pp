# == Class: gocd::common::repository::debian
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

class gocd::common::repository::debian (
  $comment     = 'ThoughtWorks GoCD APT Repository',
  $fingerprint = '9A439A18CBD07C3FF81BCE759149B0A6173454C7',
  $location    = 'http://dl.bintray.com/gocd/gocd-deb/',
  $keyserver   = 'pgp.mit.edu',
) {
  apt::key { 'thoughtworks-gocd':
    ensure => present,
    id     => $fingerprint,
    server => $keyserver,
  } ->

  apt::source { 'thoughtworks-gocd':
    location => $location,
    comment  => $comment,
    release  => '/',
    repos    => '',
  }
}
