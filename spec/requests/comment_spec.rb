require 'rails_helper'

describe 'Post requests for comments', type: :request do
    # try to add a comment to created post with the right parameters and user token (happy scenario)
    it 'Post /post/:post_id/comment' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:created)

    end

    # try to add a comment to created post with the wrong parameters and without token (unhappy scenario)
    it 'Post /post/:post_id/comment' do
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

        comment_params = {
            body: ""
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:not_acceptable)
    end
end

describe 'GET request for comments', type: :request do
    # try to get post comment with it id and user token (happy scenario)
    it 'GET /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)

        get '/post/'+ post_response_json['id'].to_s+ '/comment/'+ comment_response_json['id'].to_s, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:ok)
    end
    # try to get post comment with it id and user token (unhappy scenario)
    it 'GET /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)

        get '/post/'+ post_response_json['id'].to_s+ '/comment/' + (comment_response_json['id'] + 1).to_s , :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        expect(response).to have_http_status(:not_found)
    end
end

describe 'Update request for comments', type: :request do
    # make a user and post then try to update the post without the token (happy scenario)
    it 'Patch /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)


        update_params = {
            body: "update comment"
        }
        patch '/post/'+ post_response_json['id'].to_s+ '/comment/' + comment_response_json['id'].to_s, :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}

        expect(response).to have_http_status(:ok)
    end
    # make a user and post then make comment to that post then try to update the comment without the token (unhappy scenario)
    it 'Patch /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)


        update_params = {
            body: "update comment"
        }
        patch '/post/'+ post_response_json['id'].to_s+ '/comment/' + comment_response_json['id'].to_s, :params => comment_params.to_json, :headers => {"Content-Type": "application/json"}

        expect(response).to have_http_status(:unauthorized)
    end
end

describe 'Delete request for comments',type: :request do
    # try to delete comments with user token (happy scenario)
    it 'Delete /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)


        delete '/post/'+ post_response_json['id'].to_s+ '/comment/' + comment_response_json['id'].to_s, :headers => {"Content-Type": "application/json",  "Authorization": "Bearer " + response_json['token']}
        expect(response).to have_http_status(:ok)
    end

    # try to delete comments without user token (unhappy scenario)
    it 'Delete /post/:post_id/comment/:comment_id' do
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

        comment_params = {
            body: "try to add comment to created post"
        }
        post '/post/'+ post_response_json['id'].to_s + '/comment', :params => comment_params.to_json, :headers => {"Content-Type": "application/json" , "Authorization": "Bearer " + response_json['token']}
        comment_response_json = JSON.parse(response.body)


        delete '/post/'+ post_response_json['id'].to_s+ '/comment/' + comment_response_json['id'].to_s, :headers => {"Content-Type": "application/json"}
        expect(response).to have_http_status(:unauthorized)
    end

end