require 'active_resource'

# A Participant's legal name.
class Name < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
