# frozen_string_literal: true

class AuthRoutes < Application
  namespace '/api' do
    namespace '/v1' do
      namespace '/auth' do
        post '/signup' do
          signup_params = validate_with!(SignupParamsContract)

          result = Users::CreateService.call(*signup_params.to_h.values)
          if result.success?
            status 201
          else
            status 422
            error_response result.user
          end
        end

        post '/login' do
          login_params = validate_with!(LoginParamsContract)

          result = UserSessions::CreateService.call(*login_params.to_h.values)
          if result.success?
            token = JwtEncoder.encode(uuid: result.session.uuid)
            meta = { token: token }

            status 201
            json meta
          else
            status 401
            error_response result.session || result.errors
          end
        end
      end
    end
  end
end
