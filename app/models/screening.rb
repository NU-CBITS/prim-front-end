require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# A collection of questions asked of a Participant to determine eligibility.
class Screening < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
