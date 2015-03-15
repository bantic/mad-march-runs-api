class Api::TokensController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def new
    render json: {errors: {base: ['not logged in']}}, status: 401
  end

  def create
    self.resource = warden.authenticate(auth_options.merge(store: false))

    if warden.authenticated?(:user)
      sign_in(resource_name, resource)
      data = {
        id: 'auth-token',
        token: self.resource.authentication_token,
        email: self.resource.email,
        user:  self.resource.id
      }
      return render json: data, status: 201
    else
      return render json: {error: 'invalid login'}, status: 401
    end
  end
end
