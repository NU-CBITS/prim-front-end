require 'active_resource'

# A Participant's HIB number.
class HealthInsuranceBeneficiaryNumber < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
  self.prefix = '/participant/:external_id'
end
