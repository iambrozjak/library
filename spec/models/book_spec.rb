require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }
  let(:book) { create(:book, :with_cover, :with_content) }


  it "is persisted to the database" do
    expect(book).to be_persisted
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_numericality_of(:isbn) }
    it { is_expected.to validate_length_of( :description).is_at_most(100) }
    it { is_expected.to validate_length_of( :isbn).is_equal_to(13) }

    it { is_expected.to have_one_attached (:cover) }
    it { is_expected.to have_one_attached (:content) }
  end
end
