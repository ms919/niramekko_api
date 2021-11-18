Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.silence_get_warning = true
  provider :twitter, Rails.application.credentials.dig(:omniauth, :twitter, :api_key),
    Rails.application.credentials.dig(:omniauth, :twitter, :api_secret),
    {
      path_prefix: '/api/v1/auth',
      authorize_params: {
        force_login: 'true',
      }
    }
    # request_path: '/api/v1/auth/twitter',
    # callback_path: '/api/v1/auth/twitter/callback'
  # 認証キャンセル用処理
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end
