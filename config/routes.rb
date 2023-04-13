Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "cookies#index"

  get "/auth", to: "cookies#auth"
  get "/login", to: "cookies#login"
end
