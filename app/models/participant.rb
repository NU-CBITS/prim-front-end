require 'active_resource'

# A person registered in the system.
class Participant < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
