class PostController < ApplicationController
    before_action :authorized

    def index
        render json: Post.all
    end

    def create

        user = logged_in_user
        # save post by user references
        post = Post.new(post_params.merge(user_id: user['id']))

        if post.save
            render json: post , status: :created
        else
            render json:{message: post.errors} , status: :unprocessable_entity
        end
    end

    def show
        #retrieve post with it comments
        post = Post.find(params[:id])
        comments = post.comments #Comment.where(["post_id = :post_id", {post_id: post.id}])
        if post
            render json:{post: post , comments: comments} , status: :ok
        else
            render json:{message: "not found"}, status: :not_found
        end
    end

    def update
        # get user by token to compare user post id with user token id to allow update in post
        user = logged_in_user

        # find the specific post to update it
        post = Post.find(params[:id])

        if user['id'] == post.user_id # if ids don't match will not allow to update post
            if post.update(post_params)
                render json:{message: "update successful"} , status: :ok
            else
                render json:{message: "something went wrong"} , status: :unprocessable_entity
            end
        else
            render json:{message: "unauthorized"}, status: :unauthorized
        end

    end

    def destroy
          # get user by token to compare user post id with user token id to allow update in post
          user = logged_in_user

          # find the specific post to delete it
          post = Post.find(params[:id])

          if user['id'] == post.user_id # if ids don't match will not allow to delete post
            if post.destroy
                render json:{message:"delete successfully"}, status: :ok
            else
                render json:{message:"something went wrong"}, status: :unprocessable_entity
            end
          else
            render json:{message:"unauthorized"}, status: :unauthorized
          end

    end

    private
        def post_params
            params.require(:post).permit(:title,:body,:tags => [])
        end
end
