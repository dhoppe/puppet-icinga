class icinga::host {
	$hgroups = hiera_array('hgroups')

	icinga::host::hostgroups { $hgroups: }

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