# @summary Startup CodiMD
#
# @api private
class codimd::service (
) {
  assert_private()

  systemd::unit_file { 'codimd.service':
    source => "puppet:///modules/${module_name}/systemd.conf",
  }
  ~> service { 'codimd':
    ensure => running,
    enable => true,
  }
}
