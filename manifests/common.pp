# == Class: gocd::common
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

class gocd::common (
  $manage_dependencies = true,
  $manage_repository   = true,
  $manage_user         = true,
) {
  validate_bool($manage_dependencies)
  validate_bool($manage_repository)
  validate_bool($manage_user)

  if $manage_dependencies {
    contain '::gocd::common::dependencies'
  }

  if $manage_repository {
    contain '::gocd::common::repository'
  }

  if $manage_user {
    contain '::gocd::common::user'
  }
}
