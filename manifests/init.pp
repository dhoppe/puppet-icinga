class icinga {
	include icinga::common

	define nagios-nrpe::whitelist($whitelist = false) {
		$t_whitelist = $whitelist ? {
			false   => "127.0.0.1",
			default => $whitelist,
		}

		if $::lsbdistcodename == "lenny" {
			file { "$name":
				owner   => root,
				group   => root,
				mode    => 0644,
				alias   => "nrpe.cfg",
				notify  => Service["nagios-nrpe-server"],
				content => template("icinga/${::lsbdistcodename}/etc/nagios/nrpe.cfg.erb"),
				require => Package["nagios-nrpe-server"],
			}

			file { "/var/run/nagios":
				ensure => directory,
				owner  => nagios,
				group  => root,
				mode   => 0755,
			}
		} else {
			file { "$name":
				owner   => root,
				group   => root,
				mode    => 0644,
				alias   => "nrpe.cfg",
				notify  => Service["nagios-nrpe-server"],
				content => template("icinga/common/etc/nagios/nrpe.cfg.erb"),
				require => Package["nagios-nrpe-server"],
			}
		}
	}

	nagios-nrpe::whitelist { "/etc/nagios/nrpe.cfg":
		whitelist => hiera('whitelist'),
	}

	file { "/etc/nagios/nrpe.d":
		force   => true,
		purge   => true,
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		notify  => Service["nagios-nrpe-server"],
		source  => "puppet:///modules/icinga/common/etc/nagios/nrpe.d",
		require => Package["nagios-nrpe-server"],
	}

	file { "/usr/local/lib/nagios":
		force   => true,
		purge   => true,
		recurse => true,
		owner   => root,
		group   => staff,
		mode    => 0755,
		source  => "puppet:///modules/icinga/common/usr/local/lib/nagios",
	}

	package { [
		"binutils",
		"libnagios-plugin-perl",
		"nagios-nrpe-server",
		"nagios-plugins-basic",
		"nagios-plugins-standard" ]:
		ensure => present,
	}

	if $::lsbdistcodename == "lenny" {
		package { "ruby":
			ensure => present,
		}
	}

	service { "nagios-nrpe-server":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => false,
		pattern    => "nrpe",
		require    => [
			File["nrpe.cfg"],
			Package["nagios-nrpe-server"]
		],
	}
}

# vim: tabstop=3