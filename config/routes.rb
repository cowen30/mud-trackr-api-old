Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :events
	resources :brands
	resources :users
	scope '/participants' do
		get 'users/:id', to: 'participants#show_users'
	end
	
	post 'login', to: 'login#create'
end
