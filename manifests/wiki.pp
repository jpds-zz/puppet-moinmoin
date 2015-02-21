# Configure a MoinMoin wiki instance.
define moinmoin::wiki(
  $sitename,
  $interwikiname,
  $data_dir,
  $data_underlay_dir,
  $httpd_external_auth = false,
) {
  # The base class must be included first because it is used by parameter
  # defaults.
  if ! defined(Class['moinmoin']) {
    fail('You must include the moinmoin base class before using any moinmoin defined resources')
  }

  $moin_dir = $::moinmoin::params::moin_dir

  validate_bool($httpd_external_auth)

  file { $data_dir:
    ensure => directory,
  }

  file { $data_underlay_dir:
    ensure => directory,
  }

  file { "${moin_dir}/${title}.py":
    ensure  => file,
    content => template('moinmoin/wiki.py.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
