require 'active_resource'

# An e-mail address.
class Email < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
