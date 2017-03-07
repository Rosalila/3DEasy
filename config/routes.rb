Rails.application.routes.draw do
  resources :shipping_types
  resources :orders
  resources :printables
  resources :printing_sets
  resources :printing_hubs
  devise_for :users
  resources :printers
  root "printing_hubs#index"
  get "print" => "octoprint#print"
  get '/printing_hubs/admin/:id', to: 'printing_hubs#admin_show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
