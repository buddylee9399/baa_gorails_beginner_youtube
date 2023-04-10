class OmniauthCallbacksController < ApplicationController
	# def twitter2
	# 	render plain: auth
	# 	binding.irb
	# end
		
  def twitter2
    # Rails.logger.info auth
    # render json: auth
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.refresh_token,
      # secret: auth.credentials.secret,
    )

    redirect_to twitter_accounts_path, notice: "Successfully connected your account"
    # redirect_to root_path, notice: "Successfully connected your account"
  end

  def auth
    request.env['omniauth.auth']
  end
end
