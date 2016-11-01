node default {
    $maxUploadSize = 50
    $maxUploadedFileSize = $maxUploadSize
    $maxFileUploads = 50

    package { ["php7.0-fpm", "php7.0-cli", "php7.0-curl", "php7.0-mysql", "php-redis"]: ensure => "installed" }

    service { "php7-fpm":
        ensure => running,
        enable => true
    }

    file { "/etc/php7/fpm/pool.d/www.conf":
        require => Package["php7.0-fpm"],
        source  => "puppet:///modules/main/www.conf",
        notify  => Service["php7-fpm"]
    }

    file { "/etc/php7/fpm/php.ini":
        require => Package["php7.0-fpm"],
        content  => template('main/php.ini.erb'),
        notify  => Service["php7-fpm"]
    }

    package { "nginx": ensure => "installed" }

    service { "nginx":
        ensure => running,
        enable => true
    }

    file { "/etc/nginx/sites-available/default":
        require => Package["nginx"],
        content  => template('main/nginx.conf.erb'),
        notify  => Service["nginx"]
    }

    file { ['/opt', '/opt/app', '/opt/app/web']:
        ensure => 'directory',
    }
}