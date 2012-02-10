class icinga::service {
	$sgroups = hiera_array('sgroups')

	icinga::service::servicegroups { $sgroups: }

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