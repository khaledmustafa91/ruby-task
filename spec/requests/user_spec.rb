require 'rails_helper'
describe 'Post requests for users', type: :request do
    # try to make new user and get the token (happy scenario)
    it 'POST /users' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        expect(response).to have_http_status(:created)
    end

    # try to make new user with invalid parameters (unhappy scenario)
    it 'POST /users' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaledexample.com",
                       password: "6789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        expect(response).to have_http_status(:unprocessable_entity)
    end
end

describe 'Post request for login',type: :request do
    # try to login with the correct password (happy scenario)
    it 'POST /login' do
        user_params = { user: {
                            name: "Khaled",
                            email: "khaled@example.com",
                            password: "123456789",
                            image: "1.jpg" }
                      }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }

        login_params = { user: {
                           email: "khaled@example.com",
                           password: "123456789" }
                        }
        post '/login', :params => login_params.to_json , :headers => { "Content-Type": "application/json" }

        expect(response).to have_http_status(:ok)
    end

    # try to login with the wrong password (unhappy scenario)
    it 'POST /login' do
        user_params = { user: {
                            name: "Khaled",
                            email: "khaled@example.com",
                            password: "123456789",
                            image: "1.jpg" }
                      }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }

        login_params = { user: {
                           email: "khaled@example.com",
                           password: "123489" }
                        }
        post '/login', :params => login_params.to_json , :headers => { "Content-Type": "application/json" }

        expect(response).to have_http_status(:not_acceptable)
    end
end

describe 'Delete request for user ',type: :request do
    # try to delete user with id and his token (happy scenario)
    it 'Delete /user/:user_id' do
        user_params = { user: {
                            name: "Khaled",
                            email: "khaled@example.com",
                            password: "123456789",
                            image: "1.jpg" }
                      }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        delete '/user/'+ user_response_json['user']['id'].to_s, :headers => { "Content-Type": "application/json", "Authorization": "Bearer " + user_response_json['token']}

        expect(response).to have_http_status(:no_content)
    end
    # try to delete user with id and without his token (unhappy scenario)
    it 'Delete /user/:user_id' do
        user_params = { user: {
                            name: "Khaled",
                            email: "khaled@example.com",
                            password: "123456789",
                            image: "1.jpg" }
                      }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        delete '/user/'+ user_response_json['user']['id'].to_s, :headers => { "Content-Type": "application/json"}

        expect(response).to have_http_status(:unauthorized)
    end
end