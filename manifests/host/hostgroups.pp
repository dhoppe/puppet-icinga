define icinga::host::hostgroups() {
	$alias = inline_template("<%= name.capitalize -%>")

	nagios_hostgroup { "$name":
		ensure => present,
		alias  => $alias,
		target => "/etc/icinga/objects/hostgroups.cfg",
	}
}

# vim: tabstop=3