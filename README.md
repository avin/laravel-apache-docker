About
=========

It's docker created for develope laravel application under original linux environment.

Usage
=========

#### Simple:
```sh
docker run -d -v /local-development/laravel:/var/www/laravel --name='laravel' -p 80:80 carcinogen75/laravel-apache
```

#### With mysql support:
```sh
docker run --name mysql -e MYSQL_ROOT_PASSWORD="laravel" -e MYSQL_DATABASE="laravel" -d mysql

docker run -d -v /mnt/hgfs/test/laravel:/var/www/laravel --name='laravel' -p 80:80 --link mysql:db carcinogen75/laravel-apache
```

Then edit app/config/database.php
```php
		'mysql' => array(
			'driver'    => 'mysql',
			'host'      => 'db',
			'database'  => 'laravel',
			'username'  => 'root',
			'password'  => 'laravel',
			'charset'   => 'utf8',
			'collation' => 'utf8_unicode_ci',
			'prefix'    => '',
		),
```
