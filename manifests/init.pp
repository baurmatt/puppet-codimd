#
class codimd (
  String            $version = 'master',
  Hash[String,Data] $config  = {}
) {
  include codimd::user

  class { 'codimd::install':
    version => $version,
    require => Class['codimd::user'],
  }
  
  class { 'codimd::config':
    config => $config,
  }

  exec { '/opt/codimd/node_modules/.bin/sequelize db:migrate':
    cwd         => '/opt/codimd',
    path        => [ '/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin'],
    user        => 'codimd',
    group       => 'codimd',
    refreshonly => true,
    subscribe   => [ Class['codimd::install'], Class['codimd::config'], ],
    before      => Class['codimd::service'],
  }

  exec { 'npm run build':
    cwd         => '/opt/codimd',
    path        => [ '/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin'],
    user        => 'codimd',
    group       => 'codimd',
    refreshonly => true,
    subscribe   => [ Class['codimd::install'], Class['codimd::config'], ],
    before      => Class['codimd::service'],
  }

  include codimd::service

  Class['codimd::install'] -> Class['codimd::config']
  Class['codimd::install'] ~> Class['codimd::service']
  Class['codimd::config'] ~> Class['codimd::service']
}
