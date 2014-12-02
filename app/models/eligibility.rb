# Model for the eligibility pages.
# @author Eric Schlange <eric.schlange@northwestern.edu>
class Eligibility < ActiveRecord::Base
  belongs_to :site
end
