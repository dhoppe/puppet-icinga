class icinga::host {
	icinga::host::hostgroups { [
		"lenny",
		"squeeze",
		"maverick",
		"natty" ]:
	}

	Nagios_host <<||>> {
		notify => Exec["fix-permissions"],
	}

	Nagios_hostgroup <||> {
		notify => Exec["fix-permissions"],
	}

	Nagios_hostextinfo <<||>> {
		notify => Exec["fix-permissions"],
	}
}

# vim: tabstop=3