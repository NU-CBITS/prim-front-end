require 'active_resource'

# A collection of questions asked of a Participant to determine eligibility.
class Screening < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
