require 'active_resource'

# A physical address.
class Address < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
