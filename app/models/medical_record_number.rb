require 'active_resource'

# A Participant's MRN.
class MedicalRecordNumber < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
