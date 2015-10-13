bash 'extract_module' do
  code <<-EOH
      DATE=`date +'%Y%m%d%H%M'`_init
      cd /mnt/webapps/
      sudo chown www-data:www-data parsel.me.$DATE -R
      sudo rm parsel.me -R
      sudo ln -s parsel.me.$DATE parsel.me
    EOH
end
