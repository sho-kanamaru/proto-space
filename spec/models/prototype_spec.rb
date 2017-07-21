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
  end
end
