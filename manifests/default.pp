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
package {'libicu':
	ensure => present,
}
package {'php-intl':
	ensure => present,
}
file {'webconf':
	path => '/etc/httpd/conf.d/logistics.conf',
	mode => 0644,
	source => '/vagrant/files/logistics.conf',
	require => Package['httpd']
}
file {'php.ini':
	path => '/etc/php.ini',
	mode => 0644,
	source => '/vagrant/files/php.ini'
}
selboolean {'httpd_enable_homedirs':
	name => 'httpd_enable_homedirs',
	persistent => true,
	value => on
}
selboolean {'httpd_read_user_content':
	name => 'httpd_read_user_content',
	persistent => true,
	value => on
}
package {'httpd': 
	ensure => present,
}
service {'httpd':
	provider => redhat,
	enable => true,
	ensure => running,
	require => Package['httpd'],
	subscribe => [
		File['webconf'],
		File['php.ini'],
	]
}
file {'/home/vagrant':
	ensure => directory,
	mode => 711
}
file {'/home/vagrant/Projects':
	ensure => directory,
	mode => 711,
	owner => 'vagrant',
	group => 'vagrant'
}
file {'/home/vagrant/.ssh':
	ensure => directory,
	mode => 700,
	owner => 'vagrant',
	group => 'vagrant'
}
file {'/home/vagrant/.ssh/id_rsa':
	ensure => present,
	mode => 600,
	owner => 'vagrant',
	group => 'vagrant',
	source => '/vagrant/files/id_rsa'
}
file {'/home/vagrant/.ssh/id_rsa.pub':
	ensure => present,
	mode => 600,
	owner => 'vagrant',
	group => 'vagrant',
	source => '/vagrant/files/id_rsa.pub'
}

File['/home/vagrant/.ssh'] -> File['/home/vagrant/.ssh/id_rsa']
File['/home/vagrant/.ssh'] -> File['/home/vagrant/.ssh/id_rsa.pub']

exec {'logistics.git':
	creates => '/home/vagrant/Projects/logistics/.gitignore',
	cwd => '/home/vagrant/Projects',
	command => 'git clone git@bitbucket.org:softint/logistics.git',
	path => "/usr/bin",
	user => 'vagrant',
	group => 'vagrant',
	require => [
		File['/home/vagrant/.ssh/id_rsa'],
		File['/home/vagrant/.ssh/id_rsa.pub']
	]
}

# Packages for the logistics dbsync command
package {'perl-DBI':
	ensure => present
}
package {'perl-libwww-perl':
	ensure => present
}
package {'perl-JSON':
  ensure => present
}

