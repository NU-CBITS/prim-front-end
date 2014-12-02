require 'active_resource'

# An e-mail address.
class Email < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
