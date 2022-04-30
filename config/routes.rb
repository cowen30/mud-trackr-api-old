Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :events
	resources :event_types, path: '/event-types'
	resources :event_details, path: '/event-details'
	resources :brands
	resources :users
	get '/users/:id/reset', to: 'users#reset'
	scope '/participants' do
		get 'users/:id/legionnaire', to: 'participants#legionnaire_count'
	end
	resources :participants, only: %i[create index update destroy]

	post 'login', to: 'auth#login'
	post 'create-account', to: 'auth#create'
	post 'verify-account', to: 'auth#verify'
	post 'reset-password', to: 'auth#reset'
	post 'set-new-password', to: 'auth#new_password'
	post 'change-password', to: 'auth#change_password'
end
