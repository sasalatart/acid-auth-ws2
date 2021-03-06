# == Route Map
#
#    Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         users#index
#           POST   /verify_user/:email       users#verify {:email=>/([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i}
#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy
#

Rails.application.routes.draw do
  VALID_EMAIL_REGEX = /([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i

  root to: 'users#index'

  post 'verify_user/:email', to: 'users#verify',
                             constraints: { email: VALID_EMAIL_REGEX },
                             via: :post, format: false

  resources :users, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
