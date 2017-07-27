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

    describe 'GET #edit' do
      before do
        get :edit, params: { id: user }
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the :edit templates' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do

      subject {
        Proc.new { patch :update, params: { id: user, user: { name: "sho", email: "hoge@gmail.com", group: "techcamp", profile: "expert", works: "mentor" } } }
      }

      it 'assigns the requested to @user' do
        subject.call
        expect(assigns(:user)).to eq user
      end

      it "changes @user's attributes" do
        subject.call
        user.reload
        expect(user.name).to eq("sho")
        expect(user.email).to eq("hoge@gmail.com")
        expect(user.group).to eq("techcamp")
        expect(user.profile).to eq("expert")
        expect(user.works).to eq("mentor")
      end

      it 'redirects root path' do
        subject.call
        expect(response).to redirect_to root_path
      end

      it 'sends flash messages' do
        subject.call
        expect(flash[:notice]).to eq 'edited your account in successfully.'
      end
    end
  end
end
