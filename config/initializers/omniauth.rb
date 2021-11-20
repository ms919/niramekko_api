Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.silence_get_warning = true
  OmniAuth.config.path_prefix = '/api/v1/auth'
  # 認証キャンセル用処理
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
  provider :twitter, Rails.application.credentials.dig(:omniauth, :twitter, :api_key),
    Rails.application.credentials.dig(:omniauth, :twitter, :api_secret),
    {
      authorize_params: {
        force_login: 'true',
      }
    }
  provider :google_oauth2, Rails.application.credentials.dig(:omniauth, :google, :client_id), Rails.application.credentials.dig(:omniauth, :google, :client_secret)
end
