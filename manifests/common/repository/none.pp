# == Class: gocd::common::repository::none

class gocd::common::repository::none {
  # FIXME: Consider signalling a zip-based installation.
  warning("${::osfamily} does not have a package repository.")
}
