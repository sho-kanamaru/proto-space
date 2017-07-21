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

      it 'is invalid without an email' do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it 'is invalid without a password' do
        user.password = nil
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'is invalid without a password_confirmation although with a password' do
        user.password_confirmation = ""
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it 'is invalid with a duplicate email adress' do
        another_user = create(:user)
        user.email = another_user.email
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
    end
  end
end
