require 'active_record/fixtures'

module ActiveRecord
  module ConnectionAdapters
    # nodoc
    class PostgreSQLAdapter < AbstractAdapter
      # PostgreSQL only disables referential integrity when connection
      # user is root and that is not the case.
      def disable_referential_integrity
        yield
      end
    end
  end
end

task load_fixtures: :environment do
  path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures')
  ActiveRecord::FixtureSet.create_fixtures(path, [
    :sites,
    :abouts,
    :consents,
    :contact_us_pages,
    :eligibilities,
    :fundings,
    :homes,
    :resources,
    :site_consent_form_versions
  ])
end
