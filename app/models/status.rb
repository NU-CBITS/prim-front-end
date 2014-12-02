require 'active_resource'

# The current state of a Participant.
class Status < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
