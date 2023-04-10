# Rails for Beginners Part 1: Installing Ruby on Rails
## Go rails from youtube
- https://www.youtube.com/watch?v=wkNR1hG4yOk&list=PLm8ctt9NhMNV75T9WYIrA6m9I_uw7vS56


### Rails for Beginners Part 2: How to create a new Rails app
- rails new scheduled_tweets
- hes using rails 6

### Rails for Beginners Part 3: How HTTP Requests work in the Browser
- using chrome dev tools/network tab to see what happens when a request to a website is made

### Rails for Beginners Part 4: The MVC (Model, View, Controller) Pattern?
- explained it

### Rails for Beginners Part 5: Routes and Route Types
- rails g controller about index
- in routes
```
  # get "about-us", to: 'about#index', as: :about
  # get "about-us", to: 'about#index'
  get "about", to: 'about#index'
```

### Rails for Beginners Part 6: The Root Route
- rails g controller main index
- routes: 4 different ways to setup root
```
  # get '', to: 'main#index'
  # get '/', to: 'main#index'
  # root to: "main#index"
  root "main#index"
```

### Rails for Beginners Part 7: Adding Bootstrap CSS & Javascript
- copy the cdns and put in layout/app
```
    <title>BaaGorailsBeginnerYoutube</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
```
- update main/index

```


<div class="d-flex flex-column align-items-center justify-content-center">
  <h1 class="mt-4">Welcome to Scheduled Tweets</h1>

  <div>
    <%= link_to "Learn how to build this app in Rails", "https://gorails.com/start", target: :_blank, class: "btn btn-primary" %>
    <%= link_to "GitHub", "https://github.com/excid3/scheduled_tweets", target: :_blank, class: "btn btn-primary" %>
  </div>
</div>
```

### Rails for Beginners Part 8: Using Partials for the Navbar
- update layout app
```
    <div class="container">
      <%= yield %>
    </div>
```

- add the navbar
- create shared folder
- create navbar partial
```
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <%= link_to "Scheduled Tweets", root_path, class: "navbar-brand" %>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <%= link_to "Tweets", "#", class: "nav-link" %>
        </li>
        <li class="nav-item">
          <%= link_to "Twitter Accounts", "#", class: "nav-link" %>
        </li>
        <li class="nav-item">
          <%= link_to "About", about_path, class: "nav-link" %>
        </li>
      </ul>

      <%#= render 'shared/users' %>

    </div>
  </div>
</nav>
```

- create user partial
```
<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
  <% if Current.user %>
  <li class="nav-item">
    <%= link_to Current.user.email, edit_password_path, class: "nav-link" %>
  </li>
  <li class="nav-item">
    <%= button_to "Logout", logout_path, method: :delete, class: "btn btn-outline-secondary" %>
  </li>
  <% else %>
  <li class="nav-item">
    <%= link_to "Sign Up", sign_up_path, class: "nav-link" %>
  </li>
  <li class="nav-item">
    <%= link_to "Login", sign_in_path, class: "nav-link" %>
  </li>
  <% end %>
</ul>
```

### Rails for Beginners Part 9: URL Helpers and link_to

- showed how to do link to's
- showed different ways to do routes
```
  # get "about-us", to: 'about#index', as: :about
  # get "about-us", to: 'about#index'
  get "about", to: 'about#index'

```

### Rails for Beginners Part 10: Setting up a Git repository and Flash messages
- git status
- git add .
- git commit -m "Initial commit"
- CREATING THE FLASH
- create shared/flash partial
```
_flash.html.erb


<% if flash[:notice] %>
  <div class="alert alert-info mt-4" role="alert">
    <%= flash[:notice] %>
  </div>
<% end %>
<% if flash[:alert] %>
  <div class="alert alert-warning mt-4" role="alert">
    <%= flash[:alert] %>
  </div>
<% end %>
```

- update layout app
```
    <div class="container">
      <%= render partial: "shared/flash" %>
      <%= yield %>
    </div>
```

- to test that the flash is setup properlly
- in the main controller index action
```
  def index
    flash[:notice] = "Logged in successfully"
    flash[:alert] = 'Invalid email or password'
  end
```
- refresh the root page

## CREATING A USER WITHOUT DEVISE
### Rails for Beginners Part 11: Creating the User model
- rails g model User email password_digest 
- rails db:migrate
- update gemfile
```
gem "bcrypt", "~> 3.1.7"
```
- bundle
- update user.rb
```
has_secure_password
```

- rails c
- User.all
- User.create({email: 'user1@ex.com', password: 'asdfasdf', password_confirmation: 'asdfasdf'})

### Rails for Beginners Part 12: Validations
- update user.rb
```
	has_secure_password
	validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
	validates :password, :password_confirmation, presence: true
	validates_uniqueness_of :email
```
- rails db:rollback
- rails db:migrate:redo (rollsback the migrates)
- update the migration
```
t.string :email, null: false
```
- that way the database itself gives an error not just the ruby validation code
- rails c
- user = User.create(password: 'asdfasdf')
- user.errors.any?
- user.errors

### Rails for Beginners Part 13: Creating a Sign Up Form
- rails g controller registrations new
```
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
```

- update routes
```
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
```
- create shared/form errors partial
```
_form_errors.html.erb
<% if form.object.errors.any? %>
  <div class="alert alert-danger">
    <% form.object.errors.full_messages.each do |message| %>
      <div><%= message %></div>
    <% end %>
  </div>
<% end %>
```
- create registrations/new file
```
<h1>Sign Up</h1>

<%= form_with model: @user, url: sign_up_path, data: { turbo: false } do |form| %>
  <%= render "shared/form_errors", form: form %>

  <div class="mb-3">
    <%= form.label :email %>
    <%= form.text_field :email, class: "form-control", placeholder: "steve@apple.com" %>
  </div>
  <div class="mb-3">
    <%= form.label :password %>
    <%= form.password_field :password, class: "form-control", placeholder: "password" %>
  </div>
  <div class="mb-3">
    <%= form.label :password_confirmation %>
    <%= form.password_field :password_confirmation, class: "form-control", placeholder: "password" %>
  </div>

  <div class="mb-3">
    <%= form.submit "Sign Up", class: "btn btn-primary" %>
  </div>
<% end %>
```

### Rails for Beginners Part 14: Handling Sign Up Errors
- TO TEST TO SEE WHAT A FORM IS SUBMITTING
- IN THE CONTROLLER CREATE ACTION ADD
```
  def create
    # render plain: params
    # render plain: params[:user]
```
- that will render on the page the params being passed
- refresh and create a new user, the errors should be showing and flash notices

### Rails for Beginners Part 15: Login with Session Cookies
- adding 'session' to the registrations controller, create method
```
  def create
    # render plain: params
    # render plain: params[:user]
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account"
    else
      render :new
    end
  end
```

### Rails for Beginners Part 16: Logging Out Users
- rails g controller sessions destroy
```
class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
```
- add the logout route
```
Rails.application.routes.draw do
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "logout", to: "sessions#destroy"
```

- add to navbar
```
  <li class="nav-item">
    <%= button_to "Logout", logout_path, method: :delete, class: "btn btn-outline-secondary" %>
  </li>
```

### Rails for Beginners Part 17: Login Form
- update routes
```
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
```

- update sessions controller
```
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end
```

- create the sessions/new file
```
<h1>Sign In</h1>

<%= form_with url: sign_in_path, data: {turbo: false} do |form| %>
  <div class="mb-3">
    <%= form.label :email %>
    <%= form.text_field :email, class: "form-control", placeholder: "steve@apple.com" %>
  </div>

  <div class="mb-3">
    <%= form.label :password %>
    <%= form.password_field :password, class: "form-control", placeholder: "password" %>
    <%= link_to "Forgot your password?", password_reset_path %>
  </div>

  <div class="mb-3">
    <%= form.submit "Sign In", class: "btn btn-primary" %>
  </div
<% end %>
```
- add to navbar
```
    <%= link_to "Login", sign_in_path, class: "nav-link" %>
```

- refresh and try and log in

### Rails for Beginners Part 18: Accessing the Current User
- create the models/current.rb class
```
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
```

- add to application controller

```
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end
```

- update navbar users partial
```
<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
  <% if Current.user %>
  <li class="nav-item">
    <%#= link_to Current.user.email, edit_password_path, class: "nav-link" %>
    <%= link_to Current.user.email, "#", class: "nav-link" %>
  </li>
  <li class="nav-item">
    <%= button_to "Logout", logout_path, method: :delete, class: "btn btn-outline-secondary" %>
  </li>
  <% else %>
  <li class="nav-item">
    <%= link_to "Sign Up", sign_up_path, class: "nav-link" %>
  </li>
  <li class="nav-item">
    <%= link_to "Login", sign_in_path, class: "nav-link" %>
  </li>
  <% end %>
</ul>
```

### Rails for Beginners Part 19: Edit Password
- rails g controller passwords edit update
```
  before_action :require_user_logged_in!

  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to root_path, notice: "Password updated!"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
```
- update routes
```
  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"
```

- update app controller

```
  def require_user_logged_in!
    redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
  end
```

- update navbar users partial
```
  <li class="nav-item">
    <%= link_to Current.user.email, edit_password_path, class: "nav-link" %>
  </li>
```

- update the passwords/edit file
```
<h1>Edit Password</h1>

<%= form_with model: Current.user, url: edit_password_path do |form| %>
  <% if form.object.errors.any? %>
    <div class="alert alert-danger">
      <% form.object.errors.full_messages.each do |message| %>
        <div><%= message %></div>
      <% end %>
    </div>
  <% end %>

  <div class="mb-3">
    <%= form.label :password %>
    <%= form.password_field :password, class: "form-control", placeholder: "password" %>
  </div>

  <div class="mb-3">
    <%= form.label :password_confirmation %>
    <%= form.password_field :password_confirmation, class: "form-control", placeholder: "password" %>
  </div>

  <div class="mb-3">
    <%= form.submit "Update Password", class: "btn btn-primary" %>
  </div>
<% end %>
```

### Rails for Beginners Part 20: Forgot Your Password
- rails g controller password_resets new edit
- update routes
```
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
```

- update password resets/new file
```
<h1>Forgot your password?</h1>

<%= form_with url: password_reset_path, data: {turbo: false} do |form| %>
  <div class="mb-3">
    <%= form.label :email %>
    <%= form.text_field :email, class: "form-control", placeholder: "steve@apple.com" %>
  </div>

  <div class="mb-3">
    <%= form.submit "Reset Password", class: "btn btn-primary" %>
  </div
<% end %>
```

- update password resets/edit
```
<h1>Reset your password</h1>

<%= form_with model: @user, url: password_reset_edit_path(token: params[:token]), data: {turbo: false} do |form| %>
  <% if form.object.errors.any? %>
    <div class="alert alert-danger">
      <% form.object.errors.full_messages.each do |message| %>
        <div><%= message %></div>
      <% end %>
    </div>
  <% end %>

  <div class="mb-3">
    <%= form.label :password %>
    <%= form.password_field :password, class: "form-control", placeholder: "password" %>
  </div>

  <div class="mb-3">
    <%= form.label :password_confirmation %>
    <%= form.password_field :password_confirmation, class: "form-control", placeholder: "password" %>
  </div>

  <div class="mb-3">
    <%= form.submit "Reset Password", class: "btn btn-primary" %>
  </div
<% end %>
```

- update password resets controller
```
class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password."
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your token has expired. Please try again."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
```

- update the sessions/new file
```
  <div class="mb-3">
    <%= form.label :password %>
    <%= form.password_field :password, class: "form-control", placeholder: "password" %>
    <%= link_to "Forgot your password?", password_reset_path %>
  </div>
```

- rails g mailer Password reset
- update mailer/password
```
  def reset
    @token = params[:user].signed_id(purpose: "password_reset", expires_in: 15.minutes)

    mail to: params[:user].email
  end
```

- update views/password mailer html
```
Hi <%= params[:user].email %>,

Someone requested a reset of your password.

If this was you, click the link to reset your password. The link will expire automatically in 15 minutes.

<%= link_to "Reset password", password_reset_edit_url(token: @token) %>
```
- update text version
```
Hi <%= params[:user].email %>,

Someone requested a reset of your password.

If this was you, click the link to reset your password. The link will expire automatically in 15 minutes.

<%= password_reset_edit_url(token: @token) %>
```

### Rails for Beginners Part 21: Reset Password Token Mailer
- i did it up top
-  update conf/env/dev
```
  config.action_mailer.default_url_options = { host: "localhost:3000" }
```

- restart server
- go to login, forgot password
- enter user email
- check the server logs
- go to reset link
- enter new password
- IT WORKED

### Rails for Beginners Part 22: Password Reset Update
- i did these in the previous videos
- TO TEST A SECTION OF THE APP
- IN MAIN CONTROLLER
```
  def index
    # flash[:notice] = "Logged in successfully"
    # flash[:alert] = 'Invalid email or password'
    binding.irb
  end
```

- THIS PAUSES THE APP AND OPENS A RAILS CONSOLE AT THE MOMENT SO WE CAN SEE THE PARAMS
- ctrl+D to get out of it

### Rails for Beginners Part 23: Rails Credentials
- im logged in as palmstudiosdev in twitter
- go to:https://developer.twitter.com/en/portal/dashboard
- create a new app
- the url call backs
```
his
http://localhost:3000/auth/twitter/callback
mine
http://localhost:3000/users/auth/twitter/callback
```
- i used the 'gorails-buffer' app
- regenerated the keys
- EDITOR="subl --wait" bin/rails credentials:edit

```
development:
  twitter:
    api_key: api
    api_secret: secret
```

- rails c
```
this one automatically detects the env, do for dev it will use dev keys and for prod it will use production keys
Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key)
or
Rails.application.credentials.config[:development][:twitter][:api_key]
or 
Rails.application.credentials.development.twitter.api_key
```

### [OLD] Rails for Beginners Part 24: OmniAuth URLs
- old version

### Rails for Beginners Part 24: OmniAuth URLs [Revised for Omniauth 2.0]
- DIDNT WORK I HAD TO USE TWITTER2 GEM - BELOW
- bundle add omniauth-twitter omniauth-rails_csrf_protection
- create file conf/ini/omniauth.rb

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key), Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :api_secret)
end
```

- restart server
- add the button to main/index file
```
    <%= button_to 'Connect Twitter', "/auth/twitter", method: :post, class: 'btn btn-secondary' %>
```

### USING TWITTER2 GEM
- from this video: Twitter Authentication OAuth 2 with omniauth and Rails
- https://www.youtube.com/watch?v=kgGFM4BdVSM

- add the gems
- https://github.com/unasuke/omniauth-twitter2

```
gem "omniauth", "~> 2.1"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "omniauth-twitter2", "~> 0.1.0"
```

- i created a new app in twitter console
- https://developer.twitter.com/en/portal/projects/1641510267073748998/apps/26847184/settings
- with the stocktradingnoob twitter account: stocktradinoob1641510250430750
- with the callback URL:
```
http://localhost:3000/auth/twitter2/callback
```

- create the conf/ini/omniauth.rb
```
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
    scope: 'tweet.read users.read bookmark.read space.read offline.access',
  )  
  # i took the scope out, but it was needed so i put it back
end
```

- add a routes

```
get "/auth/twitter2/callback", to: "omniauth_callbacks#twitter"
```

- rails g controller omniauth_callbacks
```
class OmniauthCallbacksController < ApplicationController
	def twitter
		render plain: request.env['omniauth.auth']
		or
		render json: request.env['omniauth.auth']
		binding.irb
	end
```

- add a button to the main/index file
```
    <%= button_to 'Connect Twitter', "/auth/twitter2", method: :post, data: {turbo: false}, class: 'btn btn-secondary' %>
```

- refresh and test out
- in the terminal window irb
```
// from here: https://github.com/unasuke/omniauth-twitter2
auth = request.env['omniauth.auth']
auth.provider
```
- IT WORKED

### Rails for Beginners Part 25: Twitter Account Model
- now we have to save that user info in our 
- rails g model TwitterAccount user:belongs_to name username image token secret
- rails db:migrate
- update user.rb
```
class User < ApplicationRecord
	has_many :twitter_accounts
	validates :username, uniqueness: true
```

- update omniauths_callbacks controller

```
class OmniauthCallbacksController < ApplicationController
	# def twitter2
	# 	render plain: auth
	# 	binding.irb
	# end
		
  def twitter2
    # Rails.logger.info auth
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )

    # redirect_to twitter_accounts_path, notice: "Successfully connected your account"
    redirect_to root_path, notice: "Successfully connected your account"
  end

  def auth
    request.env['omniauth.auth']
  end
end
```
- update main/index

```
<div class="">
  <%= Current.user.twitter_accounts.inspect%>
  <%= image_tag Current.user.twitter_accounts.first.image %>
</div>
```

- refresh and click the connect twitter button
- IT WORKED

### Rails for Beginners Part 26: Table Plus
- just showing how to use TABLE PLUS to see the database table

### Rails for Beginners Part 27: Twitter Accounts Page
- add to routes
```
resources :twitter_accounts
```

- rails g controller twitter_accounts index new edit show
- update twitter accounts controller
```
  before_action :require_user_logged_in!
  before_action :set_twitter_account, only: [:destroy]

  def index
    @twitter_accounts = Current.user.twitter_accounts
  end

  def destroy
    @twitter_account.destroy
    redirect_to twitter_accounts_path, notice: "Successfully disconnected @#{@twitter_account.username}"
  end

  private

  def set_twitter_account
    @twitter_account = Current.user.twitter_accounts.find(params[:id])
  end
```

- update twitter accounts index
```
<div class="d-flex align-items-center justify-content-between">
  <h1>Twitter Accounts</h1>
  <%= button_to "Connect a Twitter account", "/auth/twitter2", method: :post, data: {turbo: false}, class: "btn btn-primary" %>
</div>

<% @twitter_accounts.each do |twitter_account| %>
  <div class="d-flex align-items-center mb-4">
    <div class="me-4">
      <%= image_tag twitter_account.image, class: "rounded-circle" %>
      <%= link_to "@#{twitter_account.username}", "https://twitter.com/#{twitter_account.username}", target: :_blank %>
    </div>

    <%= button_to "Disconnect", twitter_account, method: :delete, data: { confirm: "Are you sure?" } %>
  </div>
<% end %>

```

- update omniauth callbacks controller
```
    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )

    redirect_to twitter_accounts_path, notice: "Successfully connected your account"
```

### [OLD] Rails for Beginners Part 27: Twitter Accounts Page
- older version

### Rails for Beginners Part 28: Setting Records with Before Actions
- did it in the previous videos, setting the before action set twitter accoutns

### Rails for Beginners Part 29: Tweets Index & New Actions
- rails g model Tweet user:belongs_to twitter_account:belongs_to body:text publish_at:datetime tweet_id 
- rails db:migrate
- update routes
```
  resources :tweets
```

- rails g controller tweets index new edit show
```
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet was scheduled successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "Tweet was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet was unscheduled"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
  end

  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end
end
```

- update the user.rb
```
  has_many :tweets
```
- update twtitter account.rb
```
  has_many :tweets, dependent: :destroy
```

- verify tweet.rb
```
class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account
end
```

- update navbar
```
        <li class="nav-item">
          <%= link_to "Tweets", tweets_path, class: "nav-link" %>
        </li>
```

- tweets/index
```
<div class="d-flex justify-content-between align-items-center">
  <h1>Tweets</h1>

  <% if Current.user.twitter_accounts.any? %>
    <%= link_to "Schedule a Tweet", new_tweet_path, class: "btn btn-primary" %>
  <% end %>
</div>

<% if Current.user.twitter_accounts.none? %>
  <%= link_to "Connect your Twitter Account", "/auth/twitter", class: "btn btn-primary" %>
<% end %>

<%= render @tweets %>
```

- tweets/tweet partial
```
<div class="mb-3 card card-body">
  <%= tweet.body %>
  <div class="me-4">
    <%= image_tag tweet.twitter_account.image, class: "rounded-circle" %>
    <%= link_to "@#{tweet.twitter_account.username}", "https://twitter.com/#{tweet.twitter_account.username}", target: :_blank %>

    <% if tweet.published? %>
      <%= link_to "View Tweet", "https://twitter.com/#{tweet.twitter_account.username}/status/#{tweet.tweet_id}", target: :_blank %>
    <% else %>
      Scheduled for <%= l tweet.publish_at, format: :long %>
      <%= link_to "Edit Tweet", edit_tweet_path(tweet) %>
    <% end %>
  </div>
</div>
```

- tweets/new
```
<h1>Schedule A Tweet</h1>

<%= render "form", tweet: @tweet %>
```

- tweets/edit
```
<h1>Edit Scheduled Tweet</h1>

<%= render "form", tweet: @tweet %>
```

- tweets/form partial
```
<%= form_with model: tweet, data: {turbo: false} do |form| %>
  <%= render "shared/form_errors", form: form %>

  <div class="mb-3">
    <%= form.label :twitter_account_id %>
    <%= form.collection_select :twitter_account_id, Current.user.twitter_accounts, :id, :username, {}, { class: "form-control" } %>
    <%#= link_to "Connect your Twitter Account", "/auth/twitter2", method: :post, data: {turbo: false}, class: 'btn btn-secondary' if Current.user %>
  </div>

  <div class="mb-3">
    <%= form.label :body %>
    <%= form.text_area :body, class: "form-control" %>
  </div>

  <div class="mb-3">
    <%= form.label :publish_at %>
    <div class="form-control">
      <%= form.datetime_select :publish_at %>
    </div>
  </div>

  <%= form.submit "Schedule", class: "btn btn-primary" %>

  <% if form.object.persisted? %>
    <%= button_to "Delete", form.object, method: :delete, data: { confirm: "Are you sure?", turbo: false }, class: "btn btn-outline-danger" %>
  <% end %>
<% end %> 
```

### Rails for Beginners Part 30: Tweet Validations
- update tweet.rb
```
  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true
  # when the form loads to set default values
  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

```

- added the create and private params in the tweets controller that is up above
- created the forms error partial i had done before

### Rails for Beginners Part 31: Tweet Partial
- update the tweets controller

```
  def index
    @tweets = Current.user.tweets
  end
```

- create the tweets index
```
<div class="d-flex justify-content-between align-items-center">
  <h1>Tweets</h1>

  <% if Current.user.twitter_accounts.any? %>
    <%= link_to "Schedule a Tweet", new_tweet_path, class: "btn btn-primary" %>
  <% end %>
</div>

<% if Current.user.twitter_accounts.none? %>
  <%= link_to "Connect your Twitter Account", "/auth/twitter", class: "btn btn-primary" %>
<% end %>

<%= render @tweets %>
```

- create the tweet partial
```
<div class="mb-3 card card-body">
  <%= tweet.body %>
  <div class="me-4">
    <%= image_tag tweet.twitter_account.image, class: "rounded-circle" %>
    <%= link_to "@#{tweet.twitter_account.username}", "https://twitter.com/#{tweet.twitter_account.username}", target: :_blank %>

    <% if tweet.published? %>
      <%= link_to "View Tweet", "https://twitter.com/#{tweet.twitter_account.username}/status/#{tweet.tweet_id}", target: :_blank %>
    <% else %>
      Scheduled for <%= l tweet.publish_at, format: :long %>
      <%= link_to "Edit Tweet", edit_tweet_path(tweet) %>
    <% end %>
  </div>
</div>
```
- check out the way he prints out date and time
```
*************
      Scheduled for <%= l tweet.publish_at, format: :long %>
```

- update tweet.rb
```
  def published?
    tweet_id?
  end
```

### Rails for Beginners Part 32: Edit and Destroy Tweets
- added the edit link thats up above
- add the edit view
```
<h1>Edit Scheduled Tweet</h1>

<%= render "form", tweet: @tweet %>
```

- added the update action in tweets controller from up above
- add the destroy in the controller
- added the destroy button in the form
```
*************
  <% if form.object.persisted? %>
    <%= link_to "Delete", form.object, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-outline-danger" %>
  <% end %>
```

### Rails for Beginners Part 33: Twitter API
- bundle add twitter
- restart server
- update twitter account.rb
```
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key)
      config.consumer_secret     = Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :api_secret)
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
```

- update tweet.rb
```
  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
```

- rails c
- t = Tweet.last
- t.publish_to_twitter!
- it didnt work, because the call back never gave an access token secret
- i went back to the twitter app and clicked on acess token and secret and added it to the credentials
```
development:
  twitter:
    api_key: asdfasdf
    api_secret: asdfasdf
    access_token: asdfasdf
    access_token_secret: asdfasdf
```
- i updated the twitter_account.rb
```
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.dig(Rails.env.to_sym,:twitter,:api_key)
      config.consumer_secret     = Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :api_secret)
      config.access_token        = Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :access_token)
      config.access_token_secret = Rails.application.credentials.dig(Rails.env.to_sym,:twitter, :access_token_secret)
    end
  end
```
- restart console and server
- rails c
- rails c
- t = Tweet.last
- t.publish_to_twitter!
- STILL DIDNT WORK, I THINK THEY BLOCKED FREE API USAGE
- INSTEAD OF SECRET TOKEN RETURNED THERE IS A REFRESH TOKEN
- SO I UPDATE OMNIAUTH CALLBACKS CONTROLLER
```
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.refresh_token,
      # secret: auth.credentials.secret,
    )
```

- AND IT STILL FAILED

### Rails for Beginners Part 34: Background Job for Posting Tweets
- rails g job Tweet
```
class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    # Rescheduled a tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end

# Push the publish_at forward
# noon -> 8am
# -
# 8am -> sets tweet id
# Noon -> published, does nothing

# Push the publish_at forward
# 9am -> 1pm
# -
# 9am -> should do nothing
# 1pm -> should publish the tweet and set the tweet_id
```

- update tweet.rb
```
  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end
```

### Rails for Beginners Part 35: Editing Tweets
- he changed the delete in the tweet form because its a button to which is a submit, but theres already a submit so it does it again
```
  <% if form.object.persisted? %>
    <%= link_to "Delete", form.object, method: :delete, data: { confirm: "Are you sure?", turbo: false }, class: "btn btn-outline-danger" %>
  <% end %>
<% end %> 
```

### Rails for Beginners Part 36: Background Jobs with Sidekiq
- the reason to use this is if the jobs are relying only on the rails server, if the rails server goes down, we lose all the jobs pending, whereas with this the jobs will still be queued up
- brew install redis
- brew info redis
- brew services start redis
- sidekiq (runs sidekiq)
- conf/env/dev and env/prod
```
config.active_job.queue_adapter = :sidekiq
```

- rails s
- rails c
- TweetJob.perform_later(Tweet.last)
- in the terminal sidekiq you should see the tweet
- TESTING THE JOB
- in the tweet_job
```
  def perform(tweet)
    binding.irb
    return if tweet.published?
```
- rails c
- TweetJob.perform_now(Tweet.last) (use now instead of later)
- tweet (to see the tweet being passed)
- tweet.published? (to see that it should be false because it hasnt been published yet)
- tweet.publish_at (to see the time we set it to)
- tweet.publish_at > Time.current (returns true if set in the future)

### Rails for Beginners Part 37: Creating a GitHub Repo to store our
- create a new repo
- public
- follow instructions
- pushed it to github

### Rails for Beginners Part 38: Deploying to Heroku
- DIDNT DO IT CUZ NOT FREE

### Rails for Beginners Part 39: Dependent Destroy Model Associations
- update twitter_account.rb
```
  has_many :tweets, dependent: :destroy
```

### [OLD] Rails for Beginners Part 40: OmniAuth CSRF Protection
- there was a vulnerability but it was updated above when we added the csrf gem

### How to build a Multithreaded HTTP Server in Ruby from Scratch
- DIDNT DO IT

### HTTP Server from Scratch: Rack & Rails Support
- DIDNT DO IT

# THE END