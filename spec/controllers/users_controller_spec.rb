require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:prototypes) { create_list(:prototype, 3, user: user) }

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

      it 'assigns the requested to @prototypes' do
        expect(assigns(:prototypes)).to match(prototypes.sort{ |a, b| b.likes_count <=> a.likes_count } )
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
      context 'with valid attributes' do

        before do
          patch :update, params: { id: user, user: { name: "sho", email: "hoge@gmail.com", group: "techcamp", profile: "expert", works: "mentor" } }
        end

        it 'assigns the requested to @user' do
          expect(assigns(:user)).to eq user
        end

        it "changes @user's attributes" do
          user.reload
          expect(user.name).to eq("sho")
          expect(user.email).to eq("hoge@gmail.com")
          expect(user.group).to eq("techcamp")
          expect(user.profile).to eq("expert")
          expect(user.works).to eq("mentor")
        end

        it 'redirects root path' do
          expect(response).to redirect_to root_path
        end

        it 'shows flash messages to show update account successfully' do
          expect(flash[:notice]).to eq 'edited your account in successfully.'
        end
      end

      context 'with invalid attributes' do

        before do
          patch :update, params: { id: user, user: { name: "", email: "hoge@gmail.com", group: "techcamp", profile: "expert", works: "mentor" } }
          @originalname = user.name
        end

        it 'assigns the requested to @user' do
          expect(assigns(:user)).to eq user
        end

        it 'does not update the new account' do
          user.reload
          expect(user.name).to eq @originalname
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end

        it 'shows flash messages to show update account unsuccessfully' do
          expect(flash[:alert]).to eq 'cannot updated your account.'
        end
      end
    end
  end

  context 'without user login' do

    describe 'GET #show' do
      it 'redirects sign_in page' do
        get :show, params: { id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #edit' do
      it 'redirects sign_in page' do
        get :edit, params: { id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end

     describe 'PATCH #update' do

      before do
        patch :update, params: { id: user, user: { name: "sho", email: "hoge@gmail.com", group: "techcamp", profile: "expert", works: "mentor" } }
      end

      it 'redirects sign_in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
