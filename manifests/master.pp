class icinga::master inherits icinga {
	include icinga::command
	include icinga::contact
	include icinga::host
	include icinga::service

	exec { "external-commands":
		command => "dpkg-statoverride --update --add nagios nagios 751 /var/lib/icinga && dpkg-statoverride --update --add nagios www-data 2710 /var/lib/icinga/rw",
		unless  => "dpkg-statoverride --list nagios nagios 751 /var/lib/icinga && dpkg-statoverride --list nagios www-data 2710 /var/lib/icinga/rw",
		notify  => Service["icinga"],
	}

	# Bug: 3299
	exec { "fix-permissions":
		command     => "chmod -R go+r /etc/icinga/objects",
		refreshonly => true,
		notify      => Service["icinga"],
	}

	file { "/etc/icinga":
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "configs",
		notify  => Service["icinga"],
		source  => "puppet:///modules/icinga/${::lsbdistcodename}/etc/icinga",
		require => Package["icinga"],
		before  => Class['icinga::command']
	}

	file { "/etc/icinga/htpasswd.users":
		owner   => root,
		group   => root,
		mode    => 0644,
		source  => "puppet:///modules/icinga/common/etc/icinga/htpasswd.users",
		require => Package["icinga"],
	}

	file { "/etc/icinga/objects":
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "objects",
		notify  => Service["icinga"],
		source  => "puppet:///modules/icinga/common/etc/icinga/objects",
		require => Package["icinga"],
	}

	package { [
		"icinga",
		"nagios-nrpe-plugin" ]:
		ensure => present,
	}

	service { "icinga":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			File["configs"],
			File["objects"],
			Package["icinga"]
		],
	}
}

# vim: tabstop=3