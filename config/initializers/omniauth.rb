Rails.application.config.middleware.use OmniAuth::Builder do
  # provider(
  # :twitter, 
  # Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key), 
  # Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :api_secret),
  # )
  provider :developer if Rails.env.development?

  provider(
    :twitter2,
    Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key),
    Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :api_secret),
    callback_path: '/auth/twitter2/callback',
    scope: 'tweet.write tweet.read users.read bookmark.read space.read offline.access',
  )  
end

