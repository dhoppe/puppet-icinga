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
		notify => Exec["fix-permissions"],
	}

	Nagios_contactgroup <||> {
		notify => Exec["fix-permissions"],
	}
}

# vim: tabstop=3