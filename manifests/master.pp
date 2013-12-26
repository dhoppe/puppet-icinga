class icinga::master inherits icinga {
  include icinga::command
  include icinga::contact
  include icinga::host
  include icinga::service

  exec { 'external-commands':
    command => '/usr/sbin/dpkg-statoverride --update --add nagios nagios 751 /var/lib/icinga && dpkg-statoverride --update --add nagios www-data 2710 /var/lib/icinga/rw',
    unless  => '/usr/sbin/dpkg-statoverride --list nagios nagios 751 /var/lib/icinga && dpkg-statoverride --list nagios www-data 2710 /var/lib/icinga/rw',
    notify  => Service['icinga'],
  }

  # Bug: 3299
  exec { 'fix-permissions':
    command     => '/bin/chmod -R go+r /etc/icinga/objects',
    refreshonly => true,
    notify      => Service['icinga'],
  }

  if $::lsbdistcodename == 'squeeze' {
    file { '/etc/default/npcd':
      owner   => root,
      group   => root,
      mode    => '0644',
      alias   => 'npcd',
      source  => "puppet:///modules/icinga/${::lsbdistcodename}/etc/default/npcd",
      notify  => Service['npcd'],
      require => Package['pnp4nagios'],
    }
  }

  file { '/etc/icinga':
    recurse => true,
    owner   => root,
    group   => root,
    mode    => '0644',
    alias   => 'configs',
    notify  => Service['icinga'],
    source  => "puppet:///modules/icinga/${::lsbdistcodename}/etc/icinga",
    require => Package['icinga'],
  }

  file { '/etc/icinga/htpasswd.users':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('icinga/common/etc/icinga/htpasswd.users.erb'),
    require => Package['icinga'],
  }

  file { '/etc/icinga/objects':
    recurse => true,
    owner   => root,
    group   => root,
    mode    => '0644',
    alias   => 'objects',
    notify  => Service['icinga'],
    source  => [
      "puppet:///modules/icinga/${::lsbdistcodename}/etc/icinga/objects",
      'puppet:///modules/icinga/common/etc/icinga/objects'
    ],
    require => Package['icinga'],
  }

  file { [
    '/etc/icinga/objects/contacts_icinga.cfg',
    '/etc/icinga/objects/extinfo_icinga.cfg',
    '/etc/icinga/objects/generic-host_icinga.cfg',
    '/etc/icinga/objects/generic-service_icinga.cfg',
    '/etc/icinga/objects/hostgroups_icinga.cfg',
    '/etc/icinga/objects/localhost_icinga.cfg',
    '/etc/icinga/objects/services_icinga.cfg',
    '/etc/icinga/objects/timeperiods_icinga.cfg' ]:
    ensure => absent,
  }

  package { [
    'icinga',
    'nagios-nrpe-plugin' ]:
    ensure => present,
  }

  if $::lsbdistcodename == 'squeeze' {
    package { 'pnp4nagios':
      ensure => present,
    }
  }

  resources { 'nagios_command':
    purge => true,
  }

  resources { 'nagios_contact':
    purge => true,
  }

  resources { 'nagios_contactgroup':
    purge => true,
  }

  resources { 'nagios_host':
    purge => true,
  }

  resources { 'nagios_hostgroup':
    purge => true,
  }

  resources { 'nagios_hostextinfo':
    purge => true,
  }

  resources { 'nagios_service':
    purge => true,
  }

  resources { 'nagios_servicegroup':
    purge => true,
  }

  service { 'icinga':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [
      File['configs'],
      File['objects'],
      Package['icinga']
    ],
  }

  if $::lsbdistcodename == 'squeeze' {
    service { 'npcd':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => [
        File['npcd'],
        Package['pnp4nagios']
      ],
    }
  }
}
