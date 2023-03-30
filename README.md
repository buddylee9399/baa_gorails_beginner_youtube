# Rails for Beginners Part 1: Installing Ruby on Rails
## Go rails from youtube
- https://www.youtube.com/watch?v=wkNR1hG4yOk&list=PLm8ctt9NhMNV75T9WYIrA6m9I_uw7vS56

## its in the imac
- /Users/fdr/Documents/WebDev2023/baa_gorails_beginner_youtube

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
- copy the cds and put in layout/app
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
- 