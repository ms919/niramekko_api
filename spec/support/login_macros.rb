module LoginHelper
	def login_as(user)
    user.update(token: SecureRandom.urlsafe_base64)
    valid_params = { session: { token: user.token } }
    post '/api/v1/login', params: valid_params, as: :json
	end

  def auth_as(user)
    user.update(token: SecureRandom.urlsafe_base64)
    return user.token
  end
end
