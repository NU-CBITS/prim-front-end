require 'yaml'

# A website for an Intervention.
class Site < ActiveRecord::Base
  after_create :create_default_site_content

  has_one :about
  has_one :home
  has_one :contact_us_page
  has_one :eligibility
  has_one :funding
  has_one :resource
  has_one :intervention
  has_one :consent
  has_one :point_of_contact
  has_many :site_images
  has_many :user_consents

  def create_default_site_content
    create_home(title: 'Home Title', content: defaults['home'])
    create_resource(title: 'Resources', content: defaults['resource'])
    create_about(title: 'About Us', content: defaults['about'])
    create_consent(header: defaults['consent']['header'],
                   body: defaults['consent']['body'],
                   footer: defaults['consent']['footer'])
    create_contact_us_page(title: 'Contact Us', content: defaults['contact_us'])
    create_eligibility(title: 'Eligibility', content: defaults['eligibility'])
    create_funding(title: 'Funding', content: defaults['funding'])
    create_intervention(name: 'Intervention',
                        description: defaults['intervention'])
    create_point_of_contact(title: 'title',
                            name: 'name',
                            street_address: 'street address',
                            city: 'city',
                            state: 'state',
                            zip: 'zip',
                            email: 'email')
  end

  def template_name_enum
    [%w(SimpleMap simplemap), %w(Bootstagram bootstagram), %w(Tempus tempus)]
  end

  private

  def defaults
    @defaults ||= (
      content_path = File.join(Rails.root,
                               'lib/template_structured_content',
                               template_name + '_default_content.yml')

      YAML.load(File.read(content_path))
    )
  end
end
