require 'rails_helper'

describe Prototype do

  let(:user) { create(:user) }
  let(:prototype) { create(:prototype, user: user) }

  describe 'associations' do
    context 'with comments' do
      it "deletes the comments when prototype is deleted" do
        comment = create(:comment, prototype: prototype, user: user)
        expect{ prototype.destroy }.to change(Comment, :count).by(-1)
      end
    end

    context 'with likes' do
      it "deletes the likes when prototype is deleted" do
        like = create(:like, prototype: prototype, user: user)
        expect{ prototype.destroy }.to change(Like, :count).by(-1)
      end
    end
  end

  describe 'associations' do
    context 'with valid attributes' do
      it "has a valid factory" do
        expect(prototype).to be_valid
      end
    end

    context 'without valid attributes' do
      it "is missing title" do
        prototype.title = nil
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end

      it "is missing catch_copy" do
        prototype.catch_copy = nil
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end
    end
  end
end
