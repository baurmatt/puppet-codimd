class codimd::install (
  String $version,
) {
  assert_private()

  include nodejs

  package { 'yarn':
    provider => 'npm',
  }

  file { '/opt/codimd':
    ensure => directory,
    owner  => 'codimd',
    group  => 'codimd',
  }
  -> vcsrepo { '/opt/codimd':
    provider => 'git',
    user     => 'codimd',
    group    => 'codimd',
    source   => 'https://github.com/codimd/server.git',
    revision => '1.5.0',
  }
  ~> exec { '/opt/codimd/bin/setup':
    cwd         => '/opt/codimd',
    user        => 'codimd',
    group       => 'codimd',
    refreshonly => true,
  }
}
