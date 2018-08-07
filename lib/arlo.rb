require 'dotenv'
Dotenv.load

require_relative 'arlo/network_helper'

module Arlo
  require 'arlo/version'
  require 'arlo/init'
  require 'arlo/profile'
  require 'arlo/devices'
  require 'arlo/library'
end
