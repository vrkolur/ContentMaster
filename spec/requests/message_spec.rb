require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    let(:role) {FactoryBot.create(:role,title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let (:client) {FactoryBot.create(:client)}
    let(:article) {FactoryBot.create(:article,client_id: client.id)}

    before(:each) do
      sign_in user
    end


    it 'should render all the notifications for that author' do 
      get all_messages_path(client_id: client.id)
      expect(response).to have_http_status(200)
    end

    it 'should mark the message as read ' do 
      message = FactoryBot.create(:message)
      post message_path(client_id: client.sub_domain,id: message.id)
      expect(response).to have_http_status(300)
    end
  end
end
