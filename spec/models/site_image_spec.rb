require 'rails_helper'

RSpec.describe SiteImage, type: :model do
  it 'accepts valid attributes' do
    SiteImage.create!(position: 1)
  end
end
