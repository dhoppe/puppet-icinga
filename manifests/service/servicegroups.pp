define icinga::service::servicegroups() {
  $alias = inline_template('<%= name.capitalize -%>')

  nagios_servicegroup { $name:
    ensure => present,
    alias  => $alias,
    target => '/etc/icinga/objects/servicegroups.cfg',
  }
}