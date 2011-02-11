Channelgameroom::Application.routes.draw do

  root :to => "welcome#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#auth_failure", :as => :auth_failure

  resources :games
  match "/games/:id/videos" => "games#videos"

  match "/likes/vote" => "likes#vote", :as => :vote

  resources :systems
  match "/systems/:system/games" => "systems#show", :as => :system_games

end
