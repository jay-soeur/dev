import "webserver.pp"
import "dbserver.pp"

node /^www\..+\.dev$/ {
  class {"dbserver":}
}

node /^www\..+\.com$/ {
  class {"webserver":}
}

node default {

}