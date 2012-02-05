class icinga::host {
	icinga::host::hostgroups { [
		"lenny",
		"squeeze",
		"maverick",
		"natty" ]:
	}

	Nagios_host <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}

	Nagios_hostgroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}

	Nagios_hostextinfo <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}
}

# vim: tabstop=3