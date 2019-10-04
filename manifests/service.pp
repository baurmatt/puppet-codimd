class codimd::service (
) {
  assert_private()

  systemd::unit_file { 'codimd.service':
    content => template("${module_name}/systemd.conf.erb"),
  }
  ~> service { 'codimd':
    ensure => running,
    enable => true,
  }
}
