Rails.application.routes.draw do
  VALID_EMAIL_REGEX = /([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/

  post 'users/verify/:email', to: 'users#verify',
                              constraints: { email: VALID_EMAIL_REGEX },
                              via: :post, format: false

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
