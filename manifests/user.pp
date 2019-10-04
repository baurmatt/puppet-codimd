# @summary Configure the CodiMD application user
#
# @api private
class codimd::user (
) {
  assert_private()

  group { 'codimd':
    system => true,
  }
  -> user { 'codimd':
    home   => '/opt/codimd',
    shell  => '/usr/sbin/nologin',
    system => true,
  }
}
