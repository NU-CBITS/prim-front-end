# Model for the project pages.
class Project < ActiveRecord::Base
  belongs_to :site
end
