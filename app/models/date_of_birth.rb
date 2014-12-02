require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# The calendar date on which a person was born.
class DateOfBirth < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
