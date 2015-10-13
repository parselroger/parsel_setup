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
  shell '/bin/bash'
  home '/home/jenkins'
end

directory '/home/jenkins/.ssh' do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create
end



ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sudoers")
    file.insert_line_if_no_match("jenkins ALL=(ALL) NOPASSWD: ALL", "jenkins ALL=(ALL) NOPASSWD: ALL")
    file.write_file
  end
end

file '/home/jenkins/.ssh/authorized_keys' do
  content 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAsCZ5vwsdzekPHHnuVLNCxZE1hHQqxEBabuVOmCM8SY+dMkjb3RPiLy09UPIQ0Qohct45Y51oYl6v27SP7dXeGdkphZzNSLmtaj16awYzEe1apTh61Yyz8pAz63cfFgXu/YO/TKEdHSsOirS6LCB7ZnxYhdRAMKRiuvoDrP6nbG5eSTfGx8KmTyAqtKdHIVG/W4XdmZVhT8EuXDyse0koIvNF8AL2IfzCsqk7hyXL1kMh2AJ3HJWzzXmIu/oji6TMrOxTh2A2PPzjYBx7egti0NyuMk5bO1BNNBsPDep7xVrM4JD6jFvx3f3EeCD9w+Fw9yYygMPW7aHbvHgjFbmxPl3uNzI4VGEBBJXFpc0eLyAvGyi9mK5n0yXnb237MBf9yOZ+hca7aIrzgDcMR54Jtr79hpeeMH72JLi7gKba2OIgCp4QNqpDUFakslGobwOga0dvXIICzxNO7f8EReL/hztSfrYlCG9qVRvRQGi0fq7Rucgjr1VKvyBRGiN5+zAOSIjdM7lVEAMItX5XBlnvk0Rx4ipGisjKRrwH2UqbGv6zsFqJS2C38meJZlEEAijgBe3n0+dXbS/wseFXco8cRd2ktQliFJ3hcB9uFm8eJfeqGmWbyLtfGfuFFZ2oafA/B3+92W5e+jAKPQ++/JU/C+rpypb0Ca+CVLRco5LU4Oc= roger@parsel.me'
end



#copy phalon using ssh



