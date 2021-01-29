require 'rails_helper'

describe 'Post requests for posts', type: :request do
    # here test post request for add new post by user token (happy scenario)
    it 'Post /post' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:created)
    end
    # here test post request for add new post but without user token (unhappy scenario)
    it 'Post /post' do
        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" }

        expect(response).to have_http_status(:unauthorized)
    end
end

describe 'Get request for posts', type: :request do
    # make a user and post then try to read the post with the token (happy scenario)
    it 'GET /post/:post_id' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        post_response_json = JSON.parse(response.body)

        get '/post/'+ post_response_json['id'].to_s, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:ok)
    end

    # make a user and post then try to read the post with the token (unhappy scenario)
    it 'GET /post/:post_id ' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        post_response_json = JSON.parse(response.body)

        get '/post/'+ post_response_json['id'].to_s, :headers => {"Content-Type": "application/json"}

        expect(response).to have_http_status(:unauthorized)
    end
end


describe 'update request for posts', type: :request do
    # make a user and post then try to update the post with the token (happy scenario)
    it 'Patch /post/:post_id' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}
        post_response_json = JSON.parse(response.body)

        update_params = {
             title:"try to update post with user token and post id",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        patch '/post/'+ post_response_json['id'].to_s, :params => update_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}

        expect(response).to have_http_status(:ok)
    end

    # make a user and post then try to update the post without the token (unhappy scenario)
    it 'Patch /post/:post_id' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}
        post_response_json = JSON.parse(response.body)

        update_params = {
             title:"try to update post with user token and post id",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        patch '/post/'+ post_response_json['id'].to_s, :params => update_params.to_json, :headers => {"Content-Type": "application/json"}

        expect(response).to have_http_status(:unauthorized)
    end
end

describe 'Delete request for posts', type: :request do
    # make a user and post then try to delete the post with the user token (happy scenario)
    it 'Delete /post/:post_id' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}
        post_response_json = JSON.parse(response.body)

        delete '/post/'+ post_response_json['id'].to_s , :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}
        expect(response).to have_http_status(:ok)
    end

    # make a user and post then try to delete the post without the user token (unhappy scenario)
    it 'Delete /post/:post_id' do
        user_params = { user: {
                       name: "Khaled",
                       email: "khaled@example.com",
                       password: "123456789",
                       image: "1.jpg" }
        }
        post '/user', :params => user_params.to_json,:headers => { "Content-Type": "application/json" }
        user_response_json = JSON.parse(response.body)

        post_params = {
             title:"try to post with user token",
             body:"RESTful api for books application",
             tags: ["ruby" , "ruby on rails","api"]
        }
        post '/post', :params => post_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + user_response_json['token']}
        post_response_json = JSON.parse(response.body)

        delete '/post/'+ post_response_json['id'].to_s , :headers => {"Content-Type": "application/json"}
        expect(response).to have_http_status(:unauthorized)
    end
end

