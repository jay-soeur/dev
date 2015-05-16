class webserver {
  class {
    'nginx':
      port => 8080,
      document_root => "/usr/share/nginx/html",
  }->
  class {
    'php-fpm':
      user => 'nginx'
  }
}