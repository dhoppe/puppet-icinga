define icinga::whitelist($whitelist = false) {
  $t_whitelist = $whitelist ? {
    false   => '127.0.0.1',
    default => $whitelist,
  }

  if $::lsbdistcodename == 'lenny' {
    file { $name:
      owner   => root,
      group   => root,
      mode    => '0644',
      alias   => 'nrpe.cfg',
      notify  => Service['nagios-nrpe-server'],
      content => template("icinga/${::lsbdistcodename}/etc/nagios/nrpe.cfg.erb"),
      require => Package['nagios-nrpe-server'],
    }

    file { '/var/run/nagios':
      ensure => directory,
      owner  => nagios,
      group  => root,
      mode   => '0755',
    }
  } else {
    file { $name:
      owner   => root,
      group   => root,
      mode    => '0644',
      alias   => 'nrpe.cfg',
      notify  => Service['nagios-nrpe-server'],
      content => template('icinga/common/etc/nagios/nrpe.cfg.erb'),
      require => Package['nagios-nrpe-server'],
    }
  }
}