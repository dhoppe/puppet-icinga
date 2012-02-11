class icinga::host {
	$hostgroups = hiera_array('hostgroups')

	icinga::host::hostgroups { $hostgroups: }

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