# == Define: gocd::server::user
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

define gocd::server::user (
  $password = undef,
) {
  validate_string($name)
  validate_string($password)

  $name_regex = '^[a-z0-9_-]{3,16}$'
  $name_error = "The username '${name}' is not valid."
  validate_re($name, $name_regex, $name_error)

  $password_regex = '^(?:\{[A-Z0-9]+\})?[a-zA-Z0-9+\/]+={0,2}$'
  $password_error = "The password hash '${password}' is not valid."
  validate_re($password, $password_regex, $password_error)

  concat::fragment { "/var/lib/go-server/passwd:${name}":
    target  => '/var/lib/go-server/passwd',
    content => "${name}:${password}\n",
  }
}
