class icinga::contact {
	$user = hiera('user')
	$group = hiera('group')

	icinga::contact::contacts { "$user":
		alias => hiera('calias'),
		email => hiera('email'),
		group => hiera('group'),
	}

	icinga::contact::contactgroups { "$group":
		alias => hiera('galias'),
	}

	Nagios_contact <||> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}

	Nagios_contactgroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}
}

# vim: tabstop=3