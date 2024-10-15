require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new user template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'initializes a new user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
        }.to change(User, :count).by(1)
      end

      it 'sets the session user_id' do
        post :create, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
        expect(session[:user_id]).to be_present
      end

      it 'redirects to the root path' do
        post :create, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        post :create, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
        expect(flash[:notice]).to eq("Successfully registered.")
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { first_name: '', last_name: 'Doe', email: 'invalid_email', password: 'password', password_confirmation: 'wrong_password' } }
        }.not_to change(User, :count)
      end

      it 'renders the new template again' do
        post :create, params: { user: { first_name: '', last_name: 'Doe', email: 'invalid_email', password: 'password', password_confirmation: 'wrong_password' } }
        expect(response).to render_template(:new)
      end

      it 'assigns the user with errors' do
        post :create, params: { user: { first_name: '', last_name: 'Doe', email: 'invalid_email', password: 'password', password_confirmation: 'wrong_password' } }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user).errors.full_messages).not_to be_empty
      end
    end
  end
end
