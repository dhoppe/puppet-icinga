define icinga::contact::contactgroups($alias = false) {
	nagios_contactgroup { "$name":
		ensure => present,
		alias  => $alias,
		target => '/etc/icinga/objects/contactgroups.cfg',
	}
}

# vim: tabstop=3