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

    describe 'GET #new' do

      before do
        get :new
      end

      it 'assigns the requested prototype to @prototype' do
         expect(assigns(:prototype)).to be_a_new(Prototype)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do

        subject {
          Proc.new { post :create, params: { prototype: attributes_for(:prototype) } }
        }

        it 'save the new prototype in the database' do
          expect{ subject.call }.to change(Prototype, :count).by(1)
        end

        it 'redirects to root_path' do
          subject.call
          expect(response).to redirect_to root_path
        end

        it 'shows flash messages to show save the prototype successfully' do
          subject.call
          expect(flash[:notice]).to eq 'posted your prototype in successfully.'
        end
      end

      context 'with invalid attributes' do

        subject {
          Proc.new { post :create, params: { prototype: attributes_for(:prototype, title: "") } }
        }

        it 'does not save the new prototype in the database' do
          expect{ subject.call }.not_to change(Prototype, :count)
        end

        it 'redirects new_prototype_path' do
          subject.call
          expect(response).to render_template :new
        end

        it 'shows flash messages to show save the prototype unsuccessfully' do
          subject.call
          expect(flash[:alert]).to eq 'cannot posted your prototype'
        end
      end
    end

  end
end
