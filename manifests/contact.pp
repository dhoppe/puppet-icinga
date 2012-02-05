class icinga::contact {
	icinga::contact::contacts { "hotkey":
		alias => "Dennis Hoppe",
		email => "icinga@${::domain}",
		group => "admins",
	}

	icinga::contact::contactgroups { "admins":
		alias => "Debian Solutions"
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