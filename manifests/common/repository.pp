# == Class: gocd::common::repository

class gocd::common::repository (
  $type = undef
) {
  $class = pick($type, downcase($::osfamily), 'none')

  if defined("::gocd::common::repository::${class}") {
    contain "::gocd::common::repository::${class}"
  }
}
