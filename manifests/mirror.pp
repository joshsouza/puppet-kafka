# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::mirror
#
# This class will install kafka with the mirror role.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*consumer_config*]
# A hash of the consumer configuration options.
#
# [*producer_config*]
# A hash of the producer configuration options.
#
# [*service_restart*]
# Boolean, if the configuration files should trigger a service restart
#
# === Examples
#
# Create the mirror service connecting to a local zookeeper
#
# class { 'kafka::mirror':
#  consumer_config => { 'client.id' => '0', 'zookeeper.connect' => 'localhost:2181' }
# }
#
class kafka::mirror (
  $consumer_config = $kafka::params::consumer_config_defaults,
  $producer_config = $kafka::params::producer_config_defaults,
  $service_restart = $kafka::params::service_restart
) inherits kafka::params {

  validate_re($::osfamily, 'RedHat|Debian\b', "${::operatingsystem} not supported")
  validate_bool($service_restart)

  class { 'kafka::mirror::install': } ->
  class { 'kafka::mirror::config': } ->
  class { 'kafka::mirror::service': } ->
  Class['kafka::mirror']
}
