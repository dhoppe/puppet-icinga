define icinga::command::commands($command = false) {
	nagios_command { "$name":
		ensure       => present,
		command_line => $command,
		target       => "/etc/icinga/objects/commands.cfg",
	}
}

# vim: tabstop=3