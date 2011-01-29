Channelgameroom::Application.routes.draw do

  root :to => "welcome#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#auth_failure", :as => :auth_failure

  resources :games
  match "/games/:id/videos" => "games#videos"
  
#  match "/likes/videolink" => "likes#videolink"

  resources :likes do
    collection do
      get "videolink"
    end
  end

end
