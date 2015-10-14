
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


#packages to install
package "php5" do
  action :upgrade
end


package "php5-dev" do
  action :upgrade
end

package "php5-mysql" do
  action :upgrade
end

package "php5-memcache" do
  action :upgrade
end

package "php5-mcrypt" do
  action :upgrade
end

package "php5-curl" do
  action :upgrade
end

package "php5-gd" do
  action :upgrade
end

package "php5-redis" do
  action :upgrade
end

package "apache2" do
  action :upgrade
end


package "libapache2-mod-php5" do
  action :upgrade
end

package "ctags" do
  action :upgrade
end

package "imagemagick" do
  action :upgrade
end

package "mysql-client" do
  action :upgrade
end

package "gcc" do
  action :upgrade
end

package "libpcre3-dev" do
  action :upgrade
end

package "git" do
  action :upgrade
end

package "make" do
  action :upgrade
end

package "php5-imagick" do
  action :upgrade
end

package "php5-geoip" do
  action :upgrade
end

bash 'extract_module' do
  code <<-EOH
      cd /usr/share/GeoIP/
      sudo wget -N -q http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
      sudo gunzip -f -q GeoLiteCity.dat.gz
      sudo ln -s -f GeoIPCity.dat GeoLiteCity.dat
    EOH
end

#copy phalcon 
remote_file '/usr/lib/php5/20121212/phalcon.so' do
  source 'https://raw.githubusercontent.com/parselroger/parsel_setup/master/lib/phalcon.so'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end







