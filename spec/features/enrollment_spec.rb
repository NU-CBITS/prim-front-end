require 'rails_helper'
require 'active_resource'

RSpec.describe 'enrollment', type: :feature do
  fixtures :all

  it 'allows the Participant to fill out a consent' do
    headers = { 'X-AUTH-TOKEN' => 'token' }
    participant = { participant: { external_id: 'abc' } }.to_json
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post '/v1/participants.json', headers, participant, 201
      mock.post '/v1/emails.json', headers, nil, 201
      mock.post '/v1/phones.json', headers, nil, 201
      mock.post '/v1/statuses.json', headers, nil, 201
      mock.post '/v1/addresses.json', headers, nil, 201
    end
    visit "/sites/#{ sites(:stepped_care).id }/users/sign_up"

    fill_in 'First name', with: 'Henry'
    fill_in 'Last name', with: 'Ford'
    fill_in 'Email', with: 'henry.ford@example.com'
    fill_in 'Phone', with: '1234567890'
    click_on 'Sign up'

    expect(page.body).to have_text 'A message with a confirmation link has ' \
                                   'been sent to your email address.'
    last_email = ActionMailer::Base.deliveries.last

    expect(last_email.subject).to eq 'Confirmation instructions'
    expect(last_email.to).to include 'henry.ford@example.com'
  end
end
