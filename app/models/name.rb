require 'active_resource'

# A Participant's legal name.
class Name < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
