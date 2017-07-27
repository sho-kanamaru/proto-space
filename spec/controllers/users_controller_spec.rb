require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { create(:user) }

  context 'with user login' do

    before do
      login_user user
    end

    describe 'GET #show' do
      before do
        get :show, params: { id: user }
      end

      it 'assigns the requested to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the :show templates' do
        expect(response).to render_template :show
      end
    end
  end
end
