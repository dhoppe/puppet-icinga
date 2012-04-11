define icinga::service::services($command = false, $group = false) {
	$t_group = $group ? {
		false   => $name,
		default => $group,
	}

	if $t_group =~ /(disk|interfaces|smart)/ {
		$t_command = "${command}${name}"
	} else {
		$t_command = $command
	}

	@@nagios_service { "${::hostname}_${name}":
		ensure              => present,
		check_command       => $t_command,
		host_name           => $::hostname,
		servicegroups       => $t_group,
		service_description => $name,
		use                 => 'generic-service',
		target              => "/etc/icinga/objects/${::hostname}_services.cfg",
	}
}

# vim: tabstop=3