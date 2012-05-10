define icinga::host::hosts() {
  @@nagios_host { $name:
    ensure     => present,
    alias      => $::hostname,
    address    => $::ipaddress,
    hostgroups => $::lsbdistcodename,
    use        => 'generic-host',
    target     => "/etc/icinga/objects/${::hostname}_hosts.cfg",
  }
}