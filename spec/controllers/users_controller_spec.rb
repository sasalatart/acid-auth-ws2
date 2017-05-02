require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    before { get :index }

    it 'assigns paginated users' do
      expect(assigns(:users)).to eq(User.paginate(page: 1))

      get :index, params: { page: 2 }
      expect(assigns(:users)).to eq(User.paginate(page: 2))
    end

    it 'renders the index action' do
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'assigns a new @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new action' do
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      let(:user) { build :user }

      before { @req = -> { post :create, params: { user: user.attributes } } }

      it 'creates a new user when given valid parameters' do
        expect(@req).to change(User, :count).by(1)
      end

      it 'redirects to the index action if it succeeds' do
        @req.call
        expect(response.status).to eq(302)
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with missing parameters' do
      let(:user_no_email) { build :user, email: nil }
      let(:user_no_image) { build :user, image: nil }

      before do
        @req_no_email = -> { post :create, params: { user: user_no_email.attributes } }
        @req_no_image = -> { post :create, params: { user: user_no_image.attributes } }
      end

      it 'does not create a user with missing parameters' do
        expect(@req_no_email).to change(User, :count).by(0)
        expect(@req_no_image).to change(User, :count).by(0)
      end

      it 're-renders the new action if it fails' do
        @req_no_email.call
        expect(response).to render_template(:new)

        @req_no_image.call
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET edit' do
    let(:user) { create :user }

    before do
      get :edit, params: { id: user.id }
    end

    it 'assigns the user obtained from the params' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit action' do
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let(:user) { create :user }

    after { user.destroy }

    context 'when changing the image' do
      before do
        @image = 'another-base64-encoded'
        put :update, params: { id: user.id, user: { image: @image } }
      end

      it 'assigns the user obtained from the params' do
        expect(assigns(:user).id).to eq(user.id)
      end

      it 'updates the user with the given image' do
        expect(assigns(:user).image).to eq(@image)
      end

      it 'redirects to the index action if it succeeds' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(users_path)
      end

      it 'does not update the user if no image is given', skip_before: true do
        request = -> { put :update, params: { id: user.id } }
        expect(request).to raise_exception(ActionController::ParameterMissing)
      end
    end

    context 'when changing the email' do
      before do
        params = { email: 'new-email@acid.cl', image: user.image }
        put :update, params: { id: user.id, user: params }
      end

      it 'does not update the email' do
        expect(assigns(:user).email).to eq(user.email)
      end
    end
  end

  describe 'DELETE user', type: :request do
    let(:user) { create :user }

    before { delete user_path(user) }
    after { user.destroy }

    it 'destroys the user' do
      expect(User.exists?(user.id)).to eq(false)
    end

    it 'redirects to the index action if it succeeds' do
      expect(response.status).to eq(302)
      expect(response).to redirect_to(users_path)
    end
  end
end
