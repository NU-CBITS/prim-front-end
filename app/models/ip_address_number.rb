require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# One of a Participant's IP addresses.
class IpAddressNumber < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
