class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found_404

    before_action :authorized, only: [:auto_login]

      def encode_token(payload)
        JWT.encode(payload, 's3cr3t')
      end

      def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
      end

      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          # header: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
      end

      def logged_in_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          email = decoded_token[0]['email']
          password = decoded_token[0]['password']
          user = User.find_by(id: user_id) # find user based on given token
          #render json: {user: user}
          # check if returned user is correct with email and password
          if user && user['email'] == email &&  BCrypt::Password.new(user['password_digest']) == password
                return user
          end

        end
      end

      def logged_in?
        !!logged_in_user
      end

      def authorized
        #logged_in?
        render json: { message: 'token missing' }, status: :unauthorized unless logged_in?

       rescue JWT::VerificationError, JWT::DecodeError
           render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      end

      private
        def not_found_404
           render json: {error_type: "404" }, status: :not_found
        end

end
