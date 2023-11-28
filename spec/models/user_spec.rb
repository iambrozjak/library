require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
