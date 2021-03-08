Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


	namespace :api, defaults: { format: :json } do
		namespace :v1 do
			resources :users, only: [:index] do
				collection do
					post 'sign_up'
					post 'login'
					get "all_users"
					post "create_user_location_share"
					get 'dashboard'

				end
				member do
					get 'public_location'
				end
			end
		end
	end
end
