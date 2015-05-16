class mysql {
  package {
    "mysql":
      ensure => installed,
  }->
  service {
    "mysql":
      ensure  => "running",
      require => [Package['mysql'],]
  }
}