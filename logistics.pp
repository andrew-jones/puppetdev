package {'pgdg-redhat91-9.1-5':
	ensure => installed,
	provider => rpm,
	source => "http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm",
}
package {'postgresql91':
	ensure => present,
	require => Package['pgdg-redhat91-9.1-5'],
}
package {'phpPgAdmin':
	ensure => present,
	require => Package['pgdg-redhat91-9.1-5'],
}
package {'pgadmin3_91':
	ensure => present,
	require => Package['pgdg-redhat91-9.1-5'],
}
package {'postgresql91-server':
	ensure => present,
	require => Package['pgdg-redhat91-9.1-5'],
}
package {'epel-release-6-8':
	ensure => installed,
	provider => rpm,
	source => "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
}
package {'xclip':
	ensure => present,
	require => Package['epel-release-6-8'],
}
package {'kernel-devel':
	ensure => present,
}
package {'gcc':
	ensure => present,
}
package {'git':
	ensure => present,
}
package {'gitk':
	ensure => present,
}
package {'git-gui':
	ensure => present,
}
package {'php':
	ensure => present,
}
package {'php-pdo':
	ensure => present,
}
package {'php-pgsql':
	ensure => present,
}
package {'php-xml':
	ensure => present,
}
package {'php-mbstring':
	ensure => present,
}
package {'php-pear':
	ensure => present,
}
package {'php-pecl-apc':
	ensure => present,
}
package {'php-process':
	ensure => present,
}
package {'gcc-c++':
	ensure => present,
}
