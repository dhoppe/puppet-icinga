class icinga::common {
  icinga::host::hosts { $::hostname: }

  icinga::host::hostextinfo { $::hostname: }

  if $::virtual == 'physical' {
    $a_disks = split($::disks, ',')
    icinga::service::services { $a_disks:
      command => 'nrpe_check_ide_smart!/dev/',
      group   => 'smart',
    }

    $a_interfaces = split($::interfaces, ',')
    icinga::service::services { $a_interfaces:
      command => 'nrpe_check_iflocal!',
      group   => 'interfaces',
    }
  }

  icinga::service::services { 'apt':
    command => 'nrpe_check_apt',
  }

  $a_mountpoints = split($::mountpoints, ',')
  icinga::service::services { $a_mountpoints:
    command => 'nrpe_check_disk!25%!10%!',
    group   => 'disks',
  }

  icinga::service::services { 'kernel':
    command => 'nrpe_check_kernel',
  }

  icinga::service::services { 'libs':
    command => 'nrpe_check_libs',
  }

  icinga::service::services { 'load':
    command => 'nrpe_check_load!5.0!4.0!3.0!10.0!6.0!4.0',
  }

  icinga::service::services { 'procs':
    command => 'nrpe_check_procs!250!400',
  }

  icinga::service::services { 'zombie':
    command => 'nrpe_check_procs_zombie!5!10',
    group   => 'procs',
  }

  icinga::service::services { 'swap':
    command => 'nrpe_check_swap!20%!10%',
  }

  icinga::service::services { 'user':
    command => 'nrpe_check_users!5!10',
  }
}