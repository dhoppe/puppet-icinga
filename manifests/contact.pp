class icinga::contact {
  $contacts = hiera('contacts')
  $contactgroups = hiera('contactgroups')

  icinga::contact::contacts { $contacts[user]:
    alias => $contacts[alias],
    email => $contacts[email],
    group => $contacts[group],
  }

  icinga::contact::contactgroups { $contactgroups[group]:
    alias => $contactgroups[alias],
  }

  Nagios_contact <||> {
    notify  => Exec['fix-permissions'],
    require => File['objects'],
  }

  Nagios_contactgroup <||> {
    notify  => Exec['fix-permissions'],
    require => File['objects'],
  }
}