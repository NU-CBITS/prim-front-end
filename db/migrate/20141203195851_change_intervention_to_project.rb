class ChangeInterventionToProject < ActiveRecord::Migration
  def change
    rename_table 'interventions', 'projects'
  end
end
