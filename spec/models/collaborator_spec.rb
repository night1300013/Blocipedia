require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { User.create() }
  let(:wiki) { Wiki.create() }

  it { is_expected.to belong_to(:wiki) }
  it { is_expected.to belong_to(:user) }
end
