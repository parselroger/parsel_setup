#packages to install
package ['php5', 
		 'php5-mysql', 
		 'php5-memcache', 
		 'php5-mcrypt', 
		 'php5-curl',
		 'php5-gd' ,
		 'php5-dev', 
		 'php5-redis',
		 'apache2',
		 'libapache2-mod-php5',
		 'ctags',
		 'imagemagick',
		 'mysql-client',
		 'gcc',
		 'libpcre3-dev',
		 'git',
		 'make',
		 'php5-imagick',
		 'php5-geoip'] do
	  action :upgrade
end




# install geoip
package "geoip-database" do
  action :upgrade
end

package "geoip-bin" do
  action :upgrade
end

package "libgeoip-dev" do
  action :upgrade
end



