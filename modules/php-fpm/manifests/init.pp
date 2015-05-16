class php-fpm (
  $user = 'apache'
){
  package {
    "php-fpm":
      ensure => installed
  }->
  file {
    "/etc/php-fpm.d/www.conf":
      mode => "0444",
      content => template("php-fpm/www.conf.erb"),
  }->
  service {
    "php-fpm":
      enable => true,
      ensure => "running",
      require => [Package['php-fpm'], File["/etc/php-fpm.d/www.conf"],]
  }
}