require 'rails_helper'

RSpec.describe "Clients", type: :request do
  describe "GET /client" do

    let(:user) {FactoryBot.create(:user,email: 'admin@email.com')}
    let(:client) {FactoryBot.create(:client)}

    before(:each) do
      sign_in user
    end


    it 'renders a new Form to create a client' do 
      get new_client_path
      expect(response).to have_http_status(:success)
    end

    it 'renders all the available clients' do 
      client1 = FactoryBot.create(:client) # To avoid the @clients.each error
      client1.name = "Name"
      get clients_path
      expect(response).to have_http_status(:success)
    end

    it 'create a client with the following params ' do
      post clients_path , params: {
        client: {
          name:"ClientTest",
          sub_domain:"client_test",
          is_active: true}
        }
      expect(response).to redirect_to(clients_path)
    end

    it 'render edit page for a client provided the client_id' do 
      get edit_client_path(id:client)
      expect(response).to have_http_status(:success)
    end

    it 'redirect to clients_path after updated params' do 
      patch client_path(id: client.id) , params: {
        client: {
          name: "Updated_client",
          sub_domain:"updated_sub_domain"}
        }
      expect(response).to redirect_to(clients_path)
    end

    it 'deletes the client without redirecting' do 
      delete client_path(id: client.sub_domain)
      expect(response).to have_http_status(:success)
    end

    it 'should return success after updated of sub_domain ' do
      client1 = FactoryBot.create(:client, name:"New_client")
      post update_sub_domain_client_path(id: client1.id), params: {
        sub_domain: "sub_domain_edit",
        id:client1.id
      }
      expect(response).to have_http_status(302)
      expect(Client.first.sub_domain).to eq("sub_domain_edit")
    end
    
    it 'should edit the active status of the client choosen' do 
      client1 = FactoryBot.create(:client, name:"New_client")
      post change_client_active_status_client_path(id: client1.id), params: {id: client1.id}
      expect(response).to have_http_status(:success)
      expect(Client.first.name).to eq("New_client")
    end
    
  end
end

