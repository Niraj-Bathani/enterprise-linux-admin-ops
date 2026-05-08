# Apache virtual host example for a WordPress-style lab
<VirtualHost *:80>
    ServerName wordpress.lab.example
    DocumentRoot /var/www/wordpress

    <Directory /var/www/wordpress>
        AllowOverride All
        Require all granted
        Options FollowSymLinks
    </Directory>

    ErrorLog /var/log/httpd/wordpress_error.log
    CustomLog /var/log/httpd/wordpress_access.log combined
</VirtualHost>
