Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :suplementos, only: %i[index]
  get "suplementos/get_bitlink", to: 'suplementos#get_bitlink' #get route, to controller
  get "suplementos/create_bitlink", to: 'suplementos#create_bitlink' #get route, to controller
end
