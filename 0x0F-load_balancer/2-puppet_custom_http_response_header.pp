#!/usr/bin/env bash
# Script that installs and configures nginx on a server

# Update the server for avoid errors on installations
exec { 'update':
  command  => 'sudo apt update -y',
  provider => shell
}
# Install nginx in the server
package { 'nginx':
  ensure  => 'installed',
  # because puppet run all the lines at time, require forces wait until the condition is met
  # asure the update before installation avoid errors
  require => Exec['update']
}
# Create index file with content "Holberton School for the win!"
file { '/var/www/html/index.html':
  content => 'Holberton School for the win!',
  # asure the installation of NGINX before execute NGINX's commands
  require => Package['nginx']
}
# Add custom header and the respectives redirecctions
exec { 'modify-default':
  command  => 'sudo sed -i "/server_name _;/a \\\n\\tadd_header X-Served-By $HOSTNAME;"\
     		/etc/nginx/sites-available/default;
	       sudo sed -i "/add_header*/a \\\n\\trewrite ^/redirect_me https://example.com/ permanent;"\
     		/etc/nginx/sites-available/default;
	       sudo sed -i "/rewrite*/a \\\n\\terror_page 404 /404.html;\\n\\n\\tlocation = /404.html {\\n\\t\\tinternal;\\n\\t}"\
     		/etc/nginx/sites-available/default;',
  provider => shell,
  require  => Package['nginx']
}
# Run service nginx
service { 'nginx':
  # repeat the procees many times as the service is running
  ensure  => 'running',
  # asure the reboot of NGNIX after the changes were made
  require => Exec['modify-default']
}