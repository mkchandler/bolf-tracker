BolfTracker::Application.routes.draw do
	resources :players
	
	resources :games do
		resources :scores
	end

	root :to => "home#index"
end