Rails.application.routes.draw do
  resources :shops, only: [:show,:update]
  resources :orders, except: :destroy
  resources :products
  resources :coupons
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
    # registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'couponcheck', to: 'coupons#checkdiscount'
  get 'checkcart', to: 'products#checkcart'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
