# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker
#
# This class will install kafka with the broker role.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*config*]
# A hash of the configuration options.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# === Examples
#
# Create a single broker instance which talks to a local zookeeper instance.
#
# class { 'kafka::broker':
#  config => { 'broker.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::broker (
  $config = $kafka::params::broker_config_defaults,
  $service_restart = $kafka::params::service_restart
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_hash($config)
  validate_bool($service_restart)

  class { 'kafka::broker::install': } ->
  class { 'kafka::broker::config': } ->
  class { 'kafka::broker::service': } ->
  Class['kafka::broker']
}
