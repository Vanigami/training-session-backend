Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:create, :show, :workouts]

 
      resources :workouts do
        resources :exercises
      end
    end
  end

end

