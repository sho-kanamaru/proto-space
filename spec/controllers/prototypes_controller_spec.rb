require 'rails_helper'

describe PrototypesController, type: :controller do

  let(:user) { create(:user) }
  let(:prototype) { create(:prototype, user: user) }
  let(:prototypes) { create_list(:prototype, 3) }
  let(:comments) { create_list(:comment, 3, prototype: prototype, user: user) }

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

    describe 'GET #show' do

      let!(:like) { create(:like, prototype: prototype, user: user) }

      before do
        get :show, params: { id: prototype }
      end

      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end

      it 'assigns the requested comment to @comment' do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'assigns the requested comments to @comments' do
        expect(assigns(:comments)).to eq comments
      end

      it 'assigns likes associated with prototype to @likes' do
        expect(assigns(:like)).to eq like
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do

      before do
        get :edit, params: { id: prototype }
      end

      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end

      it 'assigns sub_images to @sub_images' do
        expect(assigns(:sub_images)).to eq prototype.captured_images.sub
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do

      subject {
        Proc.new { patch :update, params: { id: prototype, prototype: attributes_for(:prototype, title: "sho", catch_copy: "techcamp", concept: "expert") } }
      }

        it 'assigns the requested prototype to @prototype' do
          subject.call
          expect(assigns(:prototype)).to eq prototype
        end

        it 'updates attributes of prototype' do
          subject.call
          prototype.reload
          expect(prototype.title).to eq("sho")
          expect(prototype.catch_copy).to eq("techcamp")
          expect(prototype.concept).to eq("expert")
        end

        it 'redirects to prototype_path' do
          subject.call
          expect(response).to redirect_to root_path
        end

        it 'shows flash messages to show update prototype successfully' do
          subject.call
          expect(flash[:notice]).to eq 'Prototype was successfully updated.'
        end
      end

      context 'with invalid attributes' do

        before do
          patch :update, params: { id: prototype, prototype: attributes_for(:prototype, title: "") }
          @originaltitle = prototype.title
        end

        it 'assigns the requested prototypes to @prototypes' do
          expect(assigns(:prototype)).to eq prototype
        end

        it 'does not save the new prototype' do
          prototype.reload
          expect(prototype.title).to eq @originaltitle
        end

        it 'renders the :show template' do
          expect(response).to render_template :edit
        end

        it 'shows flash messages to show update prototype unsuccessfully' do
          expect(flash[:alert]).to eq 'cannot updated your prototype'
        end
      end
    end

    describe 'DELETE #destroy' do

      let!(:prototype) { create(:prototype, user: user) }

      subject {
        Proc.new { delete :destroy, params: { id: prototype } }
      }

      it 'assigns the requested prototype to @prototype' do
        subject.call
        expect(assigns(:prototype)).to eq prototype
      end

      it 'delete the prototype' do
        expect{
          subject.call
        }.to change(Prototype,:count).by(-1)
      end

      it 'redirects to root_path' do
        subject.call
        expect(response).to redirect_to root_path
      end

      it 'shows flash messages to show delete prototype successfully' do
        subject.call
        expect(flash[:notice]).to eq 'Prototype was successfully deleted.'
      end
    end

  end
end
