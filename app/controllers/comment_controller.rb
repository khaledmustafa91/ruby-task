class CommentController < ApplicationController
    before_action :authorized
    def create
        user = logged_in_user
        post = Post.find(params[:post_id])

        comment = Comment.new(comment_params.merge(user_id: user['id'], post_id: post['id']))

        if comment.save
            render json: comment , status: :created
        else
            render json:{message: comment.errors} , status: :not_acceptable

        end
    end

    def show
        comment = Comment.find(params[:id])
        render json:comment , status: :ok
    end

    def update
        # get user by token to compare user post id with user token id to allow update comment
        user = logged_in_user

        # find the specific comment to update it
        comment = Comment.find(params[:id])

        if user['id'] == comment.user_id # if ids don't match will not allow to update comment
            if comment.update(comment_params)
                render json:{message: "update successful"} , status: :ok
            else
                render json:{message: "something went wrong"} , status: :not_acceptable
            end
        else
            render json:{message: "unauthorized"}, status: :unauthorized
        end

    end

    def destroy
        # get user by token to compare user post id with user token id to allow update comment
        user = logged_in_user

        # find the specific comment to delete it
        comment = Comment.find(params[:id])

        if user['id'] == comment.user_id # if ids don't match will not allow to delete comment
          if comment.destroy
              render json:{message:"delete successfully"}, status: :ok
          else
              render json:{message:"something went wrong"}, status: :unprocessable_entity
          end
        else
            render json:{message:"unauthorized"}, status: :unauthorized
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
