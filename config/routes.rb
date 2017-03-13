Rails.application.routes.draw do
  resources :shipping_types
  resources :orders
  resources :printables
  resources :printing_sets
  resources :printing_hubs
  #devise_for :users
  resources :printers

  get "home" => "home#index", as: "home"

  root "home#index"

  get "print" => "octoprint#print", as: "print"
  get '/printing_hubs/admin/:id', to: 'printing_hubs#admin_show', as: "printing_hub_admin_show"
  get '/cart', to: 'orders#cart', as: "cart"
  get '/printing_hub_cart/:id', to: 'orders#printing_hub_cart', as: "printing_hub_cart"
  post '/add_to_cart', to: 'orders#add_to_cart', as: "add_to_cart"
  post '/update_item_amount', to: 'orders#update_item_amount', as: "update_item_amount"
  post '/checkout', to: 'orders#checkout', as: "checkout"
  delete '/cart/:id', to: 'orders#delete_from_cart', as: "delete_item"

	devise_for :users, controllers: {
	  sessions: 'users/sessions',
	  registrations: 'users/registrations'
	}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
