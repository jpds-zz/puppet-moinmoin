# puppet-moinmoin

This Puppet module can be used to deploy Moin Moin wikis.

[![Build Status](https://travis-ci.org/jpds/puppet-moinmoin.svg?branch=master)](https://travis-ci.org/jpds/puppet-moinmoin)

## Example usage

A single wiki may be configured on a server as such:

```puppet
  class { 'moinmoin':
    wikis => {
      # Wiki / URL regex for farmconfig.py.
      'wiki' => '.*',
    }
  }

  moinmoin::wiki { 'wiki':
    sitename            => 'Wiki',
    interwikiname       => 'Wiki',
    data_dir            => '/srv/wiki/data/',
    data_underlay_dir   => '/srv/wiki/underlay/',
    httpd_external_auth => false,
  }
```

This module does not configure Apache or the like, it is expected that this
will be handled by their respective modules. An *example* for Apache may be
found below:

```puppet
  class { 'apache':
    default_mods        => false,
    default_confd_files => false,
    mpm_module          => 'prefork',
  }

  include 'apache::mod::wsgi'

  apache::vhost { 'wiki.example.com-nonssl':
    servername => 'wiki.example.com',
    port    => '80',
    docroot    => '/var/www',

    wsgi_daemon_process         => 'wsgi',
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => { '/' => '/usr/share/moin/server/moin.wsgi' },
    wsgi_daemon_process_options =>
      { user  => 'www-data',
        group => 'www-data',
        processes    => '4',
        display-name => 'moin-wsgi',
      },
  }
```

## License

See [LICENSE](LICENSE) file.
