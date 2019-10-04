# @summary Puppet Module to install and configure codiMD 
#
# @param version Which version of CodiMD should be installed. Gets passed though to the vcsrepo resource.
# @param config Configuration of CodiMD. Gets place in the "production" hash of the config.json.
class codimd (
  Hash[String,Data] $config,
  String            $version = 'master',
) {
  include codimd::user

  class { 'codimd::install':
    version => $version,
    require => Class['codimd::user'],
  }
  -> class { 'codimd::config':
    config => $config,
  }

  ['/opt/codimd/node_modules/.bin/sequelize db:migrate', 'npm run build'].each |$command| {
    exec { $command:
      cwd         => '/opt/codimd',
      path        => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin',],
      user        => 'codimd',
      group       => 'codimd',
      refreshonly => true,
      subscribe   => [ Class['codimd::install'], Class['codimd::config'], ],
      before      => Class['codimd::service'],
    }
  }

  include codimd::service

  Class['codimd::install'] ~> Class['codimd::service']
  Class['codimd::config'] ~> Class['codimd::service']
}
