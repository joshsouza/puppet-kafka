# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::producer
#
# This class will install kafka with the producer role.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*config*]
# A hash of the producer configuration options.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# === Examples
#
# Create the producer service connecting to a local zookeeper
#
# class { 'kafka::producer':
#  config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::producer (
  $service_restart = $kafka::params::service_restart
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_bool($service_restart)

  class { 'kafka::producer::install': } ->
  class { 'kafka::producer::config': } ->
  class { 'kafka::producer::service': } ->
  Class['kafka::producer']
}
