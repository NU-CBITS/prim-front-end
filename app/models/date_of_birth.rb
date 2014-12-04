require 'active_resource'

# The calendar date on which a person was born.
class DateOfBirth < ActiveResource::Base
  include Concerns::ApiConsumer

  self.site = Rails.application.config.papi_url
end
