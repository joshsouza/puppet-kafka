# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::consumer
#
# This class will install kafka with the consumer role.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*config*]
# A hash of the consumer configuration options.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# === Examples
#
# Create the consumer service connecting to a local zookeeper
#
# class { 'kafka::consumer':
#  config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
class kafka::consumer (
  $config = $kafka::params::consumer_config_defaults,
  $service_restart = $kafka::params::service_restart
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_bool($service_restart)

  class { 'kafka::consumer::install': } ->
  class { 'kafka::consumer::config': } ->
  class { 'kafka::consumer::service': } ->
  Class['kafka::consumer']
}
