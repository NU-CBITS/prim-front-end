# A form signed by a Participant indicating agreement to participate in a
# study.
class Consent < ActiveRecord::Base
  belongs_to :site
  has_many :irb_acceptance_images
end
