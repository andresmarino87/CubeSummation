Rails.application.routes.draw do
	root :to => 'cube_summation#index' 
	post 'cube_summation', to: 'cube_summation#create'
end
