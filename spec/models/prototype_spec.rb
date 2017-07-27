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

      it "is missing concept" do
        prototype.concept = nil
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end

  describe '#posted_date' do
    it "returns dates in a specified format" do
      prototype.created_at = '2017-07-16 13:25:10'
      expect(prototype_date(prototype)).to eq('Jul 16')
    end
  end

  describe '#liked_by(user)' do
    context 'when liked by a user' do
      it "returns true" do
        like = create(:like, prototype: prototype, user: user)
        expect(prototype.like_user(user)).to be_truthy
      end
    end

    context 'when not liked by a user' do
      it "returns nil" do
        expect(prototype.like_user(user)).to be_falsey
      end
    end
  end

  describe '#get_main_images' do
    it "returns an array containing main_images" do
      expect(prototype.get_main_content.model).to eq prototype.captured_images.main.first.content.model
    end
  end

  describe '#get_sub_images' do
    it "returns an array containing sub_images" do
      create(:captured_image, :sub_image, prototype: prototype)
      expect(prototype.get_sub_contents).to match_array prototype.captured_images.sub
    end
  end

  describe '#reject_sub_images(attributed)' do
    it "doesn't save a record with nil content" do
      build(:captured_image, :sub_image, prototype: prototype, content: nil)
      expect {
        prototype.update_attributes!("captured_images_attributes"=>{"0"=>{}})
      }.to_not change(CapturedImage, :count)
    end
  end
end
