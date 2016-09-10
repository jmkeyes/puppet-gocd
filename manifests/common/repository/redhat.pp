# == Class: gocd::common::repository::redhat
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

class gocd::common::repository::redhat (
  $comment     = 'ThoughtWorks GoCD YUM Repository',
  $fingerprint = '322259C82D3082B3E32AEC2ED8843F288816C449',
  $location    = 'https://download.go.cd',
  $gpg_key_url = undef,
) {
  # Lookup the RPM key from the MIT PGP key server automatically.
  $default = 'https://pgp.mit.edu/pks/lookup?op=get&options=mr&search=0x%s'

  # Use the specified key URL, or construct one from the fingerprint.
  $gpgkey = pick($gpg_key_url, sprintf($default, $fingerprint))

  yumrepo { 'thoughtworks-gocd':
    ensure   => present,
    baseurl  => $location,
    descr    => $comment,
    gpgkey   => $gpgkey,
    gpgcheck => '0',
    enabled  => '1',
  }
}
