# A SSN.
class ApiSocialSecurityNumber < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
