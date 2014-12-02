require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# A Participant's phone number.
class Phone < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
