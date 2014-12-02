# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# A SSN.
class ApiSocialSecurityNumber < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
