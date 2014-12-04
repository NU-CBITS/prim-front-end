class AddForeignKeyConstraints < ActiveRecord::Migration
  def up
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE abouts
            ADD CONSTRAINT fk_abouts_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE consents
            ADD CONSTRAINT fk_consents_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        # Consents have_many irb_acceptance_images, so this column appears to
        # be extraneous
        remove_column :consents, :irb_acceptance_image_id, :integer

        execute <<-SQL
          ALTER TABLE contact_us_pages
            ADD CONSTRAINT fk_contact_us_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE eligibilities
            ADD CONSTRAINT fk_eligibilities_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE fundings
            ADD CONSTRAINT fk_fundings_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE homes
            ADD CONSTRAINT fk_homes_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE irb_acceptance_images
            ADD CONSTRAINT fk_irb_images_consents
            FOREIGN KEY (consent_id)
            REFERENCES consents(id)
        SQL

        execute <<-SQL
          ALTER TABLE point_of_contacts
            ADD CONSTRAINT fk_point_of_contacts_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE projects
            ADD CONSTRAINT fk_projects_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE resources
            ADD CONSTRAINT fk_resources_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        # There is no corresponding ActiveRecord class, so this table appears to
        # be extraneous
        drop_table :roles

        execute <<-SQL
          ALTER TABLE screening_answers
            ADD CONSTRAINT fk_screening_answers_questions
            FOREIGN KEY (screening_question_id)
            REFERENCES screening_questions(id)
        SQL

        execute <<-SQL
          ALTER TABLE screening_questions
            ADD CONSTRAINT fk_screening_questions_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE site_consent_form_versions
            ADD CONSTRAINT fk_consent_form_versions_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE site_images
            ADD CONSTRAINT fk_site_images_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE site_images
            ADD CONSTRAINT fk_site_images_users
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL

        execute <<-SQL
          ALTER TABLE site_phis
            ADD CONSTRAINT fk_site_phis_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE sites_users
            ADD CONSTRAINT fk_sites_users_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE sites_users
            ADD CONSTRAINT fk_sites_users_users
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_admin_audits
            ADD CONSTRAINT fk_user_admin_audits_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_admin_audits
            ADD CONSTRAINT fk_user_admin_audits_users
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_consents
            ADD CONSTRAINT fk_user_consents_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_consents
            ADD CONSTRAINT fk_user_consents_users
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_screening_flags
            ADD CONSTRAINT fk_user_consents_sites
            FOREIGN KEY (site_id)
            REFERENCES sites(id)
        SQL

        execute <<-SQL
          ALTER TABLE user_screening_flags
            ADD CONSTRAINT fk_user_consents_users
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE abouts
            DROP CONSTRAINT IF EXISTS fk_abouts_sites
        SQL

        execute <<-SQL
          ALTER TABLE consents
            DROP CONSTRAINT IF EXISTS fk_consents_sites
        SQL

        add_column :consents, :irb_acceptance_image_id, :integer

        execute <<-SQL
          ALTER TABLE contact_us_pages
            DROP CONSTRAINT IF EXISTS fk_contact_us_sites
        SQL

        execute <<-SQL
          ALTER TABLE eligibilities
            DROP CONSTRAINT IF EXISTS fk_eligibilities_sites
        SQL

        execute <<-SQL
          ALTER TABLE fundings
            DROP CONSTRAINT IF EXISTS fk_fundings_sites
        SQL

        execute <<-SQL
          ALTER TABLE homes
            DROP CONSTRAINT IF EXISTS fk_homes_sites
        SQL

        execute <<-SQL
          ALTER TABLE irb_acceptance_images
            DROP CONSTRAINT IF EXISTS fk_irb_images_consents
        SQL

        execute <<-SQL
          ALTER TABLE point_of_contacts
            DROP CONSTRAINT IF EXISTS fk_point_of_contacts_sites
        SQL

        execute <<-SQL
          ALTER TABLE projects
            DROP CONSTRAINT IF EXISTS fk_projects_sites
        SQL

        execute <<-SQL
          ALTER TABLE resources
            DROP CONSTRAINT IF EXISTS fk_resources_sites
        SQL

        create_table :roles do |t|
          t.string :name
          t.string :description
        end

        execute <<-SQL
          ALTER TABLE screening_answers
            DROP CONSTRAINT IF EXISTS fk_screening_answers_questions
        SQL

        execute <<-SQL
          ALTER TABLE screening_questions
            DROP CONSTRAINT IF EXISTS fk_screening_questions_sites
        SQL

        execute <<-SQL
          ALTER TABLE site_consent_form_versions
            DROP CONSTRAINT IF EXISTS fk_consent_form_versions_sites
        SQL

        execute <<-SQL
          ALTER TABLE site_images
            DROP CONSTRAINT IF EXISTS fk_site_images_sites
        SQL

        execute <<-SQL
          ALTER TABLE site_images
            DROP CONSTRAINT IF EXISTS fk_site_images_users
        SQL

        execute <<-SQL
          ALTER TABLE site_phis
            DROP CONSTRAINT IF EXISTS fk_site_phis_sites
        SQL

        execute <<-SQL
          ALTER TABLE sites_users
            DROP CONSTRAINT IF EXISTS fk_sites_users_sites
        SQL

        execute <<-SQL
          ALTER TABLE sites_users
            DROP CONSTRAINT IF EXISTS fk_sites_users_users
        SQL

        execute <<-SQL
          ALTER TABLE user_admin_audits
            DROP CONSTRAINT IF EXISTS fk_user_admin_audits_sites
        SQL

        execute <<-SQL
          ALTER TABLE user_admin_audits
            DROP CONSTRAINT IF EXISTS fk_user_admin_audits_users
        SQL

        execute <<-SQL
          ALTER TABLE user_consents
            DROP CONSTRAINT IF EXISTS fk_user_consents_sites
        SQL

        execute <<-SQL
          ALTER TABLE user_consents
            DROP CONSTRAINT IF EXISTS fk_user_consents_users
        SQL

        execute <<-SQL
          ALTER TABLE user_screening_flags
            DROP CONSTRAINT IF EXISTS fk_user_consents_sites
        SQL

        execute <<-SQL
          ALTER TABLE user_screening_flags
            DROP CONSTRAINT IF EXISTS fk_user_consents_users
        SQL
      end
    end
  end
end
