require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }

  it  "expected to have a valid factory" do
    expect(book.valid?).to eq true
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_numericality_of(:isbn) }
    it { is_expected.to validate_length_of( :description).is_at_most(100) }
    it { is_expected.to validate_length_of( :isbn).is_equal_to(13) }
   end
end
