# Install vim plugins
exec {'vim-pathogen':
	creates => '/home/vagrant/.vim/autoload/pathogen.vim',
	cwd => '/home/vagrant',
	command => 'mkdir -p ~/.vim/autoload ~/.vim/bundle; \
	 curl -Sso ~/.vim/autoload/pathogen.vim \
	 https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant'
}
exec {'vim-sensible':
	creates => '/home/vagrant/.vim/bundle/vim-sensible',
	cwd => '/home/vagrant/.vim/bundle',
	command => 'git clone git://github.com/tpope/vim-sensible.git',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant',
	require => Exec['vim-pathogen']
}
exec {'vim-fugitive':
	creates => '/home/vagrant/.vim/bundle/vim-fugitive',
	cwd => '/home/vagrant/.vim/bundle',
	command => 'git clone git://github.com/tpope/vim-fugitive.git',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant',
	require => Exec['vim-pathogen']
}
exec {'vim-syntastic':
	creates => '/home/vagrant/.vim/bundle/syntastic',
	cwd => '/home/vagrant/.vim/bundle',
	command => 'git clone git://github.com/scrooloose/syntastic.git',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant',
	require => Exec['vim-pathogen']
}
exec {'vim-puppet':
	creates => '/home/vagrant/.vim/bundle/puppet-syntax-vim',
	cwd => '/home/vagrant/.vim/bundle',
	command => 'git clone git://github.com/puppetlabs/puppet-syntax-vim.git',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant',
	require => Exec['vim-pathogen']
}
exec {'vim-tabular':
	creates => '/home/vagrant/.vim/bundle/puppet-tabular',
	cwd => '/home/vagrant/.vim/bundle',
	command => 'git clone git://github.com/godlygeek/tabular.git',
	path => [ "/usr/bin", "/bin" ],
	user => 'vagrant',
	group => 'vagrant',
	require => Exec['vim-pathogen']
}
file {'/home/vagrant/.vimrc':
	path => '/home/vagrant/.vimrc',
	mode => 0644,
	source => '/vagrant/files/vimrc',
}
