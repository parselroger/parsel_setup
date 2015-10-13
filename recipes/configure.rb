directory '/mnt/webapps/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/etc/apache2/sites-enabled/parsel.me.conf' do
  content '<VirtualHost *:80>
    ServerName www.parsel.me
    ServerAlias parsel.me .parsel.me 

    <Directory /mnt/webapps/parsel.me/>
        Options Indexes FollowSymLinks
        AllowOverride All
 Require all granted
    </Directory>

    ServerAdmin info@parsel.me
    DocumentRoot /mnt/webapps/parsel.me/
    ErrorLog /var/log/apache2/parsel.me-error_log
    CustomLog /var/log/apache2/parsel.me-access_log combined
</VirtualHost>'
end

link '/etc/apache2/sites-enabled/000-default.conf' do
  to '/etc/apache2/sites-enabled/parsel.me.conf'
end




file '/etc/php5/mods-available/20-phalon.ini' do
  content 'extension=phalcon.so'
end

link '/etc/php5/apache2/conf.d/20-phalon.ini' do
  to '/etc/php5/mods-available/20-phalon.ini'
end


link '/etc/php5/cli/conf.d/20-phalon.ini' do
  to '/etc/php5/mods-available/20-phalon.ini'
end


user 'jenkins' do
  comment 'jenkins'
  system true
  shell '/bin/bash'
  home '/home/jenkins'
end


ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sudoers")
    file.insert_line_if_no_match("jenkins ALL=(ALL) NOPASSWD: ALL", "jenkins ALL=(ALL) NOPASSWD: ALL")
    file.write_file
  end
end

#copy phalon using ssh

bash 'extract_module' do
  code <<-EOH
	scp jenkins@mamba.openapps.com:parsel.me_build/phalcon.so /usr/lib/php5/20121212/
    EOH
end



