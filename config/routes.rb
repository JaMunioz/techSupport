Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  root "users#index"
  resources :tickets
  resources :users
  resources :requests
  resources :supervisors
  resources :comments
  resources :responses
  resources :executive_reports

  get 'tickets/new/:user_id', to: "tickets#new"
  delete 'tickets/delete/:id', to: "tickets#destroy"
  post 'users/statusUpdater', to: "users#statusUpdater"
  post 'users/set/:user_id', to: "users#set"
  post 'tickets/set/:ticket_id', to: "tickets#set"
  post 'comments/set/:ticket_id', to: "comments#set"
  get 'statistic', to:"executive_reports#statistic"
  post 'users/changeStatus', to: "users#changeStatus"

  resources :tickets do
    resources :requests, shallow: true
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :requests, shallow: true
      end
      resources :requests
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tickets do
        resources :requests, shallow: true
      end
      resources :requests
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :tickets, shallow: true
      end
      resources :requests
    end
  end
end

