class codimd::user (
) {
  group { 'codimd':
    system => true,
  }
  -> user { 'codimd':
    home   => '/opt/codimd',
    shell  => '/usr/sbin/nologin',
    system => true,
  }
}
