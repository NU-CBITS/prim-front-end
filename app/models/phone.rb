require 'active_resource'

# A Participant's phone number.
class Phone < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
