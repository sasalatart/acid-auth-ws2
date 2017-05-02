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
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns a new @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    let(:val_user) { build :user }
    let(:inv_user) { build :user, email: nil }

    before do
      @val_req = -> { post :create, params: { user: val_user.attributes } }
      @inv_req = -> { post :create, params: { user: inv_user.attributes } }
    end

    it 'creates a new user when given valid parameters' do
      expect(@val_req).to change(User, :count).by(1)
    end

    it 'redirects to the index action if it succeeds' do
      @val_req.call
      expect(response).to redirect_to(users_path)
    end

    it 'does not create a user when given invalid parameters' do
      expect(@inv_req).to change(User, :count).by(0)
    end

    it 're-renders the new action if it fails' do
      @inv_req.call
      expect(response).to render_template(:new)
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
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let(:user) { create :user }

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
end
