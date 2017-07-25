require 'rails_helper'
include ActionDispatch::TestProcess

describe CapturedImage do

  let(:image) { build(:captured_image, :main_image) }

  describe '#create' do

    it "has the wrong content format" do
      image.content = fixture_file_upload("spec/fixtures/img/TECHCAMP.tiff", 'image/tiff')
      image.valid?
      binding.pry
      expect(image.errors[:content]).to include("translation missing: en.errors.messages.extension_whitelist_error")
    end

    context 'with valid attributes' do
      it "has a valid factory" do
        expect(image).to be_valid
      end
    end

    context 'without content attributes' do
      it "returns error" do
        image.content = nil
        image.valid?
        expect(image.errors[:content]).to include("can't be blank")
      end
    end

    context 'with status attributes' do
      it "returns error" do
        image.status = nil
        image.valid?
        expect(image.errors[:status]).to include("can't be blank")
      end
    end

  end
end
