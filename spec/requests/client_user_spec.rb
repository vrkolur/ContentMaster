require 'rails_helper'

RSpec.describe "ClientUsers", type: :request do
  describe "client_user_controller" do

    let(:client) {FactoryBot.create(:client)}
    let(:role) {FactoryBot.create(:role, title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user, role_id: role.id)}
    let(:roleauthor) {FactoryBot.create(:role,title:"Author")}
    let(:client_user) {FactoryBot.create(:client_user, user_id: user.id, client_id:client.id)}
    
    before(:each) do
      sign_in user
    end
    
    it 'redirects to a new form to create a new client_user' do 
      client_user1 = FactoryBot.create(:client_user, client_id: client.id, user_id: user.id)
      get new_client_user_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
    end
    
    it 'redirects to page that ahows the list of all Auhtors of that client' do 
      client_user1 = FactoryBot.create(:client_user, client_id: client.id, user_id: user.id)
      get client_users_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/client_users")
    end
    
    it 'posts the new form to create a new client_user and redirects to home Page' do 
      client_user1 = FactoryBot.create(:client_user, client_id: client.id, user_id: user.id)
      post client_users_path(client_id: client.sub_domain,
        client_user: {
            name:"SomeName",
            email:"client_user23@email.com",
            role_id: role.id,
            password:"password"})
        expect(response).to have_http_status(302)
        expect(User.find_by(email: "client_user23@email.com").name).to eq("SomeName")
      end
      
      let(:client_user_params) do
        {
            name: "HelloAuthor",
            email: "client_user@email.com",
            role_id: roleauthor.id,
            password: "password"
          }
        end
        
        it 'creates a new ClientUser as a Author and redirects' do
          post client_users_path(client_id: client.sub_domain), params: {client_user: client_user_params }
          expect(response).to have_http_status(302)
          expect(User.find_by(email: "client_user@email.com").name).to eq("HelloAuthor")
        end
        
        let(:client_user_params1) do
          {
              name: "HelloClientAdmin",
              email: "client_user_12@email.com",
              role_id: role.id,
              password: "password"
            }
          end
          
    it 'should create a ClientUser as a Client_admin and redirects' do 
      post client_users_path(client_id: client.sub_domain), params: {client_user: client_user_params1 }
      expect(response).to have_http_status(302)
      expect(User.find_by(email: "client_user_12@email.com").name).to eq("HelloClientAdmin")
    end
    
    let(:client_user_params2) do
      {
        name: "HelloClientAdmin",
        email: "",
        role_id: role.id,
        password: "password"
      }
    end
    
    it 'should not create a ClientUser as a Client_admin with invalid params' do 
      client_user1 = FactoryBot.create(:client_user, client_id: client.id, user_id: user.id)
      post client_users_path(client_id: client.sub_domain), params: {client_user: client_user_params2 }
      expect(response).to have_http_status(422)
      expect(User.find_by(name: "HelloClientAdmin").present?).to eq(false)
    end
    
    it 'should successfully delete the client_user wit success code' do 
      delete client_user_path(client_id: client.slug,id: client_user.id), params: {id: client_user.id}
      expect(response).to have_http_status(:success)
      expect { ClientUser.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
