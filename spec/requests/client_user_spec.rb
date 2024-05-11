require 'rails_helper'

RSpec.describe "ClientUsers", type: :request do

  let(:client) {FactoryBot.create(:client)}
  let(:client_user) {FactoryBot.create(:client_user, client_id:client.id)}
  # let(:role) {FactoryBot.create(:role,name:"")}
  let(:user) {FactoryBot.create(:user)}

  before(:each) do
    sign_in user
  end

  describe "client_user_controller" do
    it 'redirects to a new form to create a new client_user' do 
      get new_client_user_path(client_id: client.sub_domain)
      expect(response).to have_http_status(302)
    end

    it 'redirects to page that ahows the list of all Auhtors of that client' do 
      get client_users_path(client_id: client.sub_domain)
      expect(response).to have_http_status(302)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/client_users")
    end

    it 'posts the new form to create a new client_user and redirects to home Page' do 
      post client_users_path(client_id: client.sub_domain), params: {
        client_user: {
          name:"Name",
          email:"client_user@email.com",
          role_id: 3,
          password:"password"}
        }
      expect(response).to have_http_status(302)
      # expect(ClientUser.first.user.name).to eq(cliet_user.user.name)
    end
    
    it 'should successfully delete the client_user wit success code' do 
      delete client_user_path(client_id: client.slug,id: client_user.id), params: {id: client_user.id}
      expect(response).to have_http_status(302)
      # expect { ClientUser.find(client_user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end
