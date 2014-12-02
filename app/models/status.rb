require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# The current state of a Participant.
class Status < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
