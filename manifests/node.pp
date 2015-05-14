node /^www\..+\.dev$/ {
  class {'nginx':
    port => 8080,
  }
}

node /^www\..+\.com$/ {
  class {'nginx':
    port => 80,
  }
}

node default {

}