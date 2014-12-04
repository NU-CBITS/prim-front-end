require 'active_resource'

# The current state of a Participant.
class Status < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
