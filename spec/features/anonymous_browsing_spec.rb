require 'rails_helper'

RSpec.describe 'anonymous browsing', type: :feature do
  fixtures :all

  it 'displays the home page' do
    visit '/'
  end
end
