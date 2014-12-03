class RenameContactUs < ActiveRecord::Migration
  def change
    rename_table 'contact_us', 'contact_us_pages'
  end
end
