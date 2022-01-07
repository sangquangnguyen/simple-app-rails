Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'sign_up' => 'sign_up#index'
  post 'sign_up' => 'sign_up#new'
  get '/verify_account/:id', to: 'sign_up#verify_account', as: 'verify_account'
  get '/about' => 'sign_up#about'
  root 'organisations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :organisations do
    resources :employees
  end
end
