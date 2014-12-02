require 'rails_helper'

RSpec.describe Site, type: :model do
  let(:site) do
    Site.create!(name: Faker::Company.name,
                 content: Faker::Lorem.paragraph(2),
                 template_name: 'simplemap')
  end

  before { site.create_default_site_content }

  it 'has a valid Home after create_default_site_content' do
    expect(site.home.title).not_to be_nil
  end

  it 'has a valid Resource after create_default_site_content' do
    expect(site.resource.title).not_to be_nil
  end

  it 'has a valid About after create_default_site_content' do
    expect(site.about.title).not_to be_nil
  end

  it 'has a valid Consent after create_default_site_content' do
    expect(site.consent.header).not_to be_nil
  end

  it 'has a valid ContactUs after create_default_site_content' do
    expect(site.contact_us.title).not_to be_nil
  end

  it 'has a valid Eligibility after create_default_site_content' do
    expect(site.eligibility.title).not_to be_nil
  end

  it 'has a valid Funding after create_default_site_content' do
    expect(site.funding.title).not_to be_nil
  end

  it 'has a valid Intervention after create_default_site_content' do
    expect(site.intervention.name).not_to be_nil
  end

  it 'has a valid PointOfContact after create_default_site_content' do
    expect(site.point_of_contact.title).not_to be_nil
  end
end
