require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  describe '#create' do

    context 'with valid attributes' do
      it 'is valid with all information' do
        expect(user).to be_valid
      end

      it "is valid with a password that has more than 8 characters" do
        user.password = "00000000"
        user.password_confirmation = "00000000"
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

      it "is invalid with a password that has less than 7 characters" do
        user.password = "0000000"
        user.password_confirmation = "0000000"
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end
  end
end
