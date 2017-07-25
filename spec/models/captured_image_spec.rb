require 'rails_helper'

describe CapturedImage do

  let(:image) { build(:captured_image, :main_image) }

  describe '#create' do

    context 'with valid attributes' do
      it "has a valid factory" do
        expect(image).to be_valid
      end
    end
  end
end
