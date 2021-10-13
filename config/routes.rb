Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :events
	resources :event_types, path: '/event-types'
	resources :brands
	resources :users
	scope '/participants' do
		get 'users/:id', to: 'participants#show_users'
		get 'users/:id/legionnaire', to: 'participants#legionnaire_count'
		get 'events/:id', to: 'participants#show_events'
	end
	resources :participants, only: %i[create update destroy]
	
	post 'login', to: 'login#create'
end
