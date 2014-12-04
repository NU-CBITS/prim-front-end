require 'active_support/concern'

module Concerns
  # Includes the authentication token in the header.
  module ApiConsumer
    extend ActiveSupport::Concern

    included do
      headers['X-AUTH-TOKEN'] = Rails.application.config.prim_resources_token
    end
  end
end
