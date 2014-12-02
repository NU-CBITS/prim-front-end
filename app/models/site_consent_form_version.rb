# @author Eric Schlange <eric.schlange@northwestern.edu>
# An instance of a Participant Consent.
class SiteConsentFormVersion < ActiveRecord::Base
  belongs_to :site
  belongs_to :user_consent
end
