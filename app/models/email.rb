require 'active_resource'

# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# An e-mail address.
class Email < ActiveResource::Base
  self.site = Rails.application.config.papi_url
end
