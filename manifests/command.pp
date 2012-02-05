class icinga::command {
	# Local
	icinga::command::commands { "check_ntp_time":
		command => '$USER1$/check_ntp_time -H $HOSTADDRESS$',
	}

	# Remote
	icinga::command::commands { "nrpe_check_apt":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_apt',
	}

	icinga::command::commands { "nrpe_check_disk":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_disk -a $ARG1$ $ARG2$ $ARG3$',
	}

	icinga::command::commands { "nrpe_check_ide_smart":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_ide_smart -a $ARG1$',
	}

	icinga::command::commands { "nrpe_check_iflocal":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_iflocal -a $ARG1$',
	}

	icinga::command::commands { "nrpe_check_mailq":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_mailq -a $ARG1$ $ARG2$',
	}

	icinga::command::commands { "nrpe_check_kernel":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_kernel',
	}

	icinga::command::commands { "nrpe_check_libs":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_libs',
	}

	icinga::command::commands { "nrpe_check_load":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_load -a $ARG1$ $ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$',
	}

	icinga::command::commands { "nrpe_check_procs":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_procs -a $ARG1$ $ARG2$',
	}

	icinga::command::commands { "nrpe_check_procs_zombie":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_procs_zombie -a $ARG1$ $ARG2$',
	}

	icinga::command::commands { "nrpe_check_puppet":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_puppet -a $ARG1$ $ARG2$',
	}

	icinga::command::commands { "nrpe_check_swap":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_swap -a $ARG1$ $ARG2$',
	}

	icinga::command::commands { "nrpe_check_users":
		command => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_users -a $ARG1$ $ARG2$',
	}

	Nagios_command <||> {
		notify  => Exec["fix-permissions"],
		require => File["objects"],
	}
}

# vim: tabstop=3