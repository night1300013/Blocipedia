require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user)}
  let(:collaborator) { create(:collaborator, user: other_user, wiki: wiki)}
  let(:wiki) { create(:wiki, user: user)}


  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:collaborators) }
  it { is_expected.to have_many(:users).through :collaborators }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
    it "has title, body, and user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: user)
    end

    it "is public by default" do
       expect(wiki.private).to be(false)
    end
  end
end
