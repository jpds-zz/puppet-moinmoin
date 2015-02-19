class moinmoin(
  $package_name = $moinmoin::params::package,
  $wikis = undef,
) inherits moinmoin::params {
  package { $package_name:
    ensure => installed,
    before => File['/etc/moin'],
  }

  validate_hash($wikis)

  file { '/etc/moin':
    ensure => directory,
    path   => $moinmoin::params::moin_dir,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/moin/farmconfig.py':
    ensure  => file,
    content => template('moinmoin/farmconfig.py.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}

