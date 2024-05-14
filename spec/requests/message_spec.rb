require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    let(:role) {FactoryBot.create(:role,title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let (:client) {FactoryBot.create(:client)}
    let(:client_user) {FactoryBot.create(:client_user,client_id:client.id, user_id: user.id)}
    let(:article) {FactoryBot.create(:article,client_id: client.id)}

    before(:each) do
      sign_in client_user.user
    end


    it 'should render all the notifications for that author' do 
      get all_messages_path(client_id: client.sub_domain)
      expect(response).to have_http_status(200)
      expect(response).to render_template('messages/all_messages')
    end

    it 'should mark the message as read ' do 
      message = FactoryBot.create(:message)
      post mark_as_read_message_path(client_id: client.sub_domain,id: message.id)
      expect(response).to have_http_status(:success)
      expect(Message.first.status).to be(true)
    end
  end
end
