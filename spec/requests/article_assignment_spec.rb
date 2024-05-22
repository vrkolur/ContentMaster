require 'rails_helper'

RSpec.describe "ArticleAssignments", type: :request do


    describe "GET /:client_id" do
        let(:role) {FactoryBot.create(:role, title: "ClientAdmin")}
        let(:user) {FactoryBot.create(:user,role_id: role.id)}
        
        it 'get the assignment page with success redirect' do 
            client = FactoryBot.create(:client)
            client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
            sign_in client_user.user
            get new_article_assignment_path(client_id: client.sub_domain)
            expect(response).to have_http_status(:success)
            expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/article_assignments/new")
        end
        
        it 'should successfully assign an article for the author and create a notification' do 
            client = FactoryBot.create(:client)
            category = FactoryBot.create(:category)
            client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
            sign_in client_user.user
            post article_assignments_path(client_id: client.sub_domain), params: {title:"NewArticle", category_id: category.id, author_id: user.id}
            expect(response).to have_http_status(302)
            expect(Message.first.sender_id).to eq(user.id)
        end

        it 'should not process and throw error rendering :new ' do 
            client = FactoryBot.create(:client)
            category = FactoryBot.create(:category)
            client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
            sign_in client_user.user 
            post article_assignments_path(client_id: client.sub_domain), params: { category_id: category.id, author_id: user.id}
            expect(response).to have_http_status(302)
            expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/article_assignments")
        end
    end

    describe "GET/ :client_id" do 
        let (:user) {FactoryBot.create(:user)}
        let(:client) {FactoryBot.create(:client)}
        let(:category) {FactoryBot.create(:category)}

        it 'should redirect to home path if not ClientAmdin or Author' do 
            sign_in user 
            get new_article_assignment_path(client_id: 'hello')
            expect(response).to have_http_status(302)
        end

        it 'should redirect is no user is present' do 
            get new_article_assignment_path(client_id: 'hello')
            expect(response).to have_http_status(302)
            expect(response.request.url).to eq("http://www.example.com/unauthenticated")
        end
    end

    describe '#check_admin' do
        let(:role) {FactoryBot.create(:role, title: "ClientAdmin")}
        let(:user) {FactoryBot.create(:user,role_id: role.id)}
        let(:category) {FactoryBot.create(:category)}


        it 'should redirect to his client page if not the client_admin for the specific page' do 
            client = FactoryBot.create(:client)
            client1 = FactoryBot.create(:client)
            client_user = FactoryBot.create(:client_user, client_id: client1.id ,user_id: user.id)
            sign_in client_user.user
            get new_article_assignment_path(client_id: client.sub_domain)
            expect(response).to redirect_to(articles_path(client_id: client1.sub_domain))
        end

    end

end
