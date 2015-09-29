# == Class: gocd::common::repository::debian

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
