# variables
$username = "Tim Brown"
$email = "timb@softint.com.au"

package {'pgdg-redhat91-9.1-5':
	ensure => installed,
	provider => rpm,
	source => "http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm"
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
package {'vim-X11':
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
	owner => 'root',
	group => 'root',
	source => '/vagrant/files/php.ini'
}
file {'/etc/sysconfig/iptables':
	path => '/etc/sysconfig/iptables',
	mode => 0600,
	owner => 'root',
	group => 'root',
	source => '/vagrant/files/iptables'
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
selboolean {'httpd_can_network_connect':
	name => 'httpd_can_network_connect',
	persistent => true,
	value => on
}
selboolean {'httpd_can_network_connect_db':
	name => 'httpd_can_network_connect_db',
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
service {'iptables':
	provider => redhat,
	enable => true,
	ensure => running,
	subscribe => File['/etc/sysconfig/iptables']
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
file {'/home/vagrant/.ssh/known_hosts':
	ensure => present,
	mode => 600,
	owner => 'vagrant',
	group => 'vagrant'
} ->
sshkey {'bitbucket.org':
	ensure => present,
	name => 'bitbucket.org',
	target => '/home/vagrant/.ssh/known_hosts',
	type => ssh-rsa,
	key => 	'AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw=='
} ->
sshkey {'github.com':
	ensure => present,
	name => 'github.com',
	target => '/home/vagrant/.ssh/known_hosts',
	type => ssh-rsa,
	key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=='
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
		File['/home/vagrant/.ssh/id_rsa.pub'],
		Sshkey['bitbucket.org']
	]
} ->
file {'/home/vagrant/Projects/logistics/app/config/parameters.yml':
	ensure => present,
	mode   => 664,
	owner  => 'vagrant',
	group  => 'vagrant',
	source => '/vagrant/files/parameters.yml'
} -> 
exec {'composer-install':
	# creates   => '/home/vagrant/Projects/logistics/.gitignore',
	cwd         => '/home/vagrant/Projects/logistics',
	command     => 'php composer.phar update',
	environment => "HOME=/home/vagrant",
	path        => [ "/usr/bin", "/bin", "/sbin" ],
	user        => 'vagrant',
	group       => 'vagrant',
	timeout     => 1200
} ->
exec {'setfacl-cache-logs':
	# creates => '/home/vagrant/Projects/logistics/.gitignore',
	cwd => '/home/vagrant/Projects/logistics',
	command => 'sudo setfacl -R -m u:apache:rwX -m u:`whoami`:rwX app/cache app/logs && sudo setfacl -dR -m u:apache:rwX -m u:`whoami`:rwX app/cache app/logs',
	path => "/usr/bin"
} ->
exec {'selinux-cache-logs':
	# creates => '/home/vagrant/Projects/logistics/.gitignore',
	cwd => '/home/vagrant/Projects/logistics',
	command => 'sudo chcon -vR --type=httpd_sys_content_t app/logs && sudo chcon -vR --type=httpd_sys_content_t app/cache && sudo chcon -vR --type=httpd_sys_content_t app/cache',
	path => "/usr/bin"
}

# Packages for the logistics dbsync command
package {'perl-DBI':
	ensure => present
}
package {'perl-DBD-Pg':
	ensure => present
}
package {'perl-libwww-perl':
	ensure => present
}
package {'perl-JSON':
  ensure => present
}

# Git user name and email setup
file {'gitconfig':
	path    => '/home/vagrant/.gitconfig',
	mode    => 0644,
	owner   => 'vagrant',
	group   => 'vagrant',
	replace => false,
	content => "[user]
	name = $username
	email = $email
"
}

# SELinux Troubleshooting packages
package {'setroubleshoot':
	ensure => present
}
