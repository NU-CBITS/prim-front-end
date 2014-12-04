require 'active_resource'

# A physical address.
class Address < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
