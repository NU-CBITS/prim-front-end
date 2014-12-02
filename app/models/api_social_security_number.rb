# A SSN.
class ApiSocialSecurityNumber < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
