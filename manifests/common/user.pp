# == Class: gocd::common::user

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
