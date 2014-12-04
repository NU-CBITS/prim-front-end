require 'active_resource'

# One of a Participant's IP addresses.
class IpAddressNumber < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
