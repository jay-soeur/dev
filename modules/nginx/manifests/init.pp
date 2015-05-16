class nginx (
  $port = 80,
  $document_root = "/var/www/html"
){

  $config_dir = $::osfamily ? {
    "Debian" => "/etc/nginx/conf.d/sites-enabled",
    default => "/etc/nginx/conf.d",
  }

  exec {
    "nginx_repo":
      command => "/usr/bin/wget http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm",
      user => "root";
  }->
  exec {
    "nginx_package":
      command => "/bin/rpm -ivh nginx-release-centos-6-0.el6.ngx.noarch.rpm",
      user => "root";
  }->
  package {
    "nginx":
      ensure => installed
  }->
  user {
    'nginx':
      ensure => present
  }->
  group {
    'nginx':
      ensure  => present,
  }->
  file {
    "${config_dir}/default.conf":
      ensure => absent;

    "${config_dir}/example_ssl.conf":
      ensure => absent;

    "/etc/nginx/nginx.conf":
      mode => "0444",
      source => "puppet:///modules/nginx/etc/nginx/nginx.conf";

    "${config_dir}/www.conf":
      mode => "0444",
      content => template("nginx/www.conf.erb"),
  }->
  service {
    "nginx":
      enable => true,
      ensure => "running",
      require => [Package['nginx'], File["${config_dir}/www.conf"],]
  }
}