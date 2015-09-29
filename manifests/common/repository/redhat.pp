# == Class: gocd::common::repository::redhat

class gocd::common::repository::redhat (
  $comment     = 'ThoughtWorks GoCD YUM Repository',
  $fingerprint = '9A439A18CBD07C3FF81BCE759149B0A6173454C7',
  $location    = 'http://dl.bintray.com/gocd/gocd-rpm',
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
