require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
end
