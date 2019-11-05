Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :suplementos, only: %i[index]
  post "suplementos/get_bitlinks", to: "suplementos#get_bitlinks" #get route, to controller
end
