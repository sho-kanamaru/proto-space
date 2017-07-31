require 'rails_helper'

describe PrototypesController, type: :controller do

  let(:user) { create(:user) }
  let(:prototype) { create(:prototype, user: user) }
  let(:prototypes) { create_list(:prototype, 3) }

  context 'with user login' do

    before do
      login_user user
    end

    describe 'GET #index' do

      before do
        get :index
      end

      it 'assigns the requested prototypes to @prototypes' do
        expect(assigns(:prototypes)).to match(prototypes.sort{ |a, b| b.likes_count <=> a.likes_count } )
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

  end

end
