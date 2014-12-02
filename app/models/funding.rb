# Model for the funding pages.
# @author Eric Schlange <eric.schlange@northwestern.edu>
class Funding < ActiveRecord::Base
  belongs_to :site
end
