# @author Eric Schlange <eric.schlange@northwestern.edu>
# An administrative User associated with a Site.
class SitesUser < ActiveRecord::Base
  self.table_name = 'sites_users'
end
