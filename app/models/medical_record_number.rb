require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# A Participant's MRN.
class MedicalRecordNumber < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
