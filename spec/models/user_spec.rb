require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  describe '#create' do

    context 'with valid attributes' do
      it 'is valid with all information' do
        expect(user).to be_valid
      end
    end

    context 'without valid attributes' do
      it 'is invalid without a name' do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
    end
  end
end
