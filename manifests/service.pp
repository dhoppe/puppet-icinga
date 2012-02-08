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
		"ssh",
		"swap",
		"user" ]:
	}

	Nagios_service <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}

	Nagios_servicegroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}
}

# vim: tabstop=3