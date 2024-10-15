require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_user_params) do
    { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
  end

  let(:invalid_user_params) do
    { first_name: '', last_name: 'Doe', email: 'invalid_email', password: 'password', password_confirmation: 'wrong_password' }
  end

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
          post :create, params: { user: valid_user_params }
        }.to change(User, :count).by(1)
      end

      it 'sets the session user_id' do
        post :create, params: { user: valid_user_params }
        expect(session[:user_id]).to be_present
      end

      it 'redirects to the root path' do
        post :create, params: { user: valid_user_params }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        post :create, params: { user: valid_user_params }
        expect(flash[:notice]).to eq("Successfully registered.")
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_user_params }
        }.not_to change(User, :count)
      end

      it 'renders the new template again' do
        post :create, params: { user: invalid_user_params }
        expect(response).to render_template(:new)
      end

      it 'assigns the user with errors' do
        post :create, params: { user: invalid_user_params }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user).errors.full_messages).not_to be_empty
      end

      it 'does not set the session user_id' do
        post :create, params: { user: invalid_user_params }
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { User.create(valid_user_params) }

    context 'with valid attributes' do
      it 'updates the user' do
        put :update, params: { id: user.id, user: { first_name: 'Jane', last_name: 'Doe', email: 'jane@example.com' } }
        user.reload
        expect(user.first_name).to eq('Jane')
        expect(user.last_name).to eq('Doe')
        expect(user.email).to eq('jane@example.com')
      end

      it 'redirects to the user show page' do
        put :update, params: { id: user.id, user: { first_name: 'Jane', last_name: 'Doe', email: 'jane@example.com' } }
        expect(response).to redirect_to(user_path(user))
      end

      it 'sets a flash notice' do
        put :update, params: { id: user.id, user: { first_name: 'Jane', last_name: 'Doe', email: 'jane@example.com' } }
        expect(flash[:notice]).to eq("User updated successfully.")
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        put :update, params: { id: user.id, user: { first_name: '', last_name: 'Doe', email: 'invalid_email' } }
        user.reload
        expect(user.first_name).to eq('John')
      end

      it 'renders the edit template' do
        put :update, params: { id: user.id, user: { first_name: '', last_name: 'Doe', email: 'invalid_email' } }
        expect(response).to render_template(:edit)
      end

      it 'assigns the user with errors' do
        put :update, params: { id: user.id, user: { first_name: '', last_name: 'Doe', email: 'invalid_email' } }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user).errors.full_messages).not_to be_empty
      end
    end

    context 'when user does not exist' do
      it 'returns a 404 status' do
        put :update, params: { id: -1, user: { first_name: 'Jane' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { User.create(valid_user_params) }

    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: user.id }
      expect(flash[:notice]).to eq("Account deleted successfully.")
    end

    context 'when user does not exist' do
      it 'returns a 404 status' do
        delete :destroy, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
