class codimd::config (
  Hash[String,Data] $config,
) {
  assert_private()

  $_config = deep_merge({ sessionSecret => fqdn_rand_string(64)}, $config)
  
  assert_type(Codimd::Db, $_config['db'])

  file { '/opt/codimd/config.json':
    ensure  => file,
    owner   => 'codimd',
    group   => 'codimd',
    content => to_json_pretty({production => $_config }),
  }

  file { '/opt/codimd/.sequelizerc':
    ensure  => file,
    owner   => 'codimd',
    group   => 'codimd',
    content => epp("${module_name}/sequelizerc.epp", {
      dialect  => $_config['db']['dialect'],
      host     => $_config['db']['host'],
      port     => $_config['db']['port'],
      username => $_config['db']['username'],
      password => $_config['db']['password'],
      database => $_config['db']['database'],
    }),
  }
}
