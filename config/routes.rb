Rails.application.routes.draw do
  root 'users#new'
  get 'users/:id' => 'users#edit'
  patch 'users/:id' => 'users#update'
  post 'users' => 'users#create'

  get 'events/' => 'events#index'
  post 'events' => 'events#create'
  get 'events/:id' => 'events#show'
  get 'events/:id/edit' => 'events#edit'
  post 'events/:id' => 'comments#create'
  get 'events/:id/join' => 'events#join_event'
  get 'events/:id/unjoin' => 'events#leave_event'

  post 'sessions' => 'sessions#create'
  get 'sessions/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
