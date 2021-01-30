class UserController < ApplicationController
    def create
        user = User.where(["email = :email" , {email: params[:user][:email]}]) # retrieve the user

        if user.count == 0  # check if user already exists or not
            user = User.new(user_params)
            if user.save
                render json: {token: encode_token({
                user_id: user.id,
                email: user.email,
                password: user.password
                }) , user: user}, status: :created
            else
                render json: user.errors , status: :unprocessable_entity
            end
        else
            render json: {messages: "user exist"} , status: :ok
        end

    end

    def login
       # check if user exist or not by email
       user_logged = User.where(["email = :email" , {email: params[:user][:email]}])

       # here we check for correct password first then encode the user data
       # and return the JWT token to use it in all processes
       if user_logged.count == 1 && BCrypt::Password.new(user_logged[0].password_digest) == params[:user][:password]

            token = encode_token({
                            user_id: user_logged[0].id,
                            email: user_logged[0].email,
                            password: params[:user][:password]
                            })
            render json: {token: token}
       else
           render json:{message: "invalid password or email"}, status: :not_acceptable
       end
    end

    def destroy
        # check if user has the right token or not
        user = logged_in_user

        # make sure that user has the same id to give him permission to delete
        if user and user['id'] == params[:id].to_i
            if user.destroy
               head :no_content
            else
               render json: user.errors , status: :unprocessable_entity
            end
        else
            render json: {message: "unauthorized"} , status: :unauthorized
        end
    end

    private
        def user_params
            params.require(:user).permit(:name,:email,:password,:image)
        end
end
