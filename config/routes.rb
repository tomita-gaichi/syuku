Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  devise_scope :user do
    get 'sign_in' =>'devise/sessions#new'
    post 'sign_in' => 'devise/sessions#create'
    delete '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/edit' => 'devise/registrations#edit'
    get 'account' => 'devise/registrations#account'
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
  end
  
  get 'users/index'
  get 'show' => 'posts#show'
  get 'reservations/:id/rooms' => 'reservations#rooms'
  post 'reservations/:id/rooms' => 'posts#create'
  get 'posts/search'
  get 'reservations/:id/kari' => 'reservations#kari', as: :reservations_kari
  post 'reservations/:id/kari' => 'reservations#create'
  get 'reservations/reshow'
  get 'reservations/new'
  resources :users

  resources :posts do
    resources :reservations do
      collection do
        post :confirm
      end
    end
  end

  root to: "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
