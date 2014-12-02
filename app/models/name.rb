require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# A Participant's legal name.
class Name < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
