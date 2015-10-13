#
# Cookbook Name:: parsel_setup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

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
		 'php5-geoip']




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


#copy phalon
directory '/mnt/webapps/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/php5/apache2/php.ini' do
  source 'php.ini.erb'
end

service 'apache2' do
  supports :status => true
  action [:enable, :start]
end

