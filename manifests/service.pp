class icinga::service {
	icinga::service::servicegroups { [
		"apt",
		"disks",
		"interfaces",
		"kernel",
		"libs",
		"load",
		"mailq",
		"ntp",
		"procs",
		"puppet",
		"smart",
		"swap",
		"user" ]:
	}

	Nagios_service <<||>> {
		require => File['/etc/icinga'],
		notify => Exec["fix-permissions"],
	}

	Nagios_servicegroup <||> {
		require => File['/etc/icinga'],
		notify => Exec["fix-permissions"],
	}
}

# vim: tabstop=3