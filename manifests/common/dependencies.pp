# == Class: gocd::common::dependencies

class gocd::common::dependencies {
  if defined('::java') == false {
    fail('You must install the puppetlabs/java module.')
  }

  include '::java'
}
