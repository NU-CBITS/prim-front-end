# A User action within the application.
class UserAdminAudit < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
end
