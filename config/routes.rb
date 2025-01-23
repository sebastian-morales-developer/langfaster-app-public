Rails.application.routes.draw do
  resources :monologues
  resources :conversations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  scope "(:locale)", locale: /af|ar|az|ba|be|bg|bs|ca|cs|cy|da|de|el|en|es|et|fa|fi|fr|gl|he|hi|hr|hu|hy|id|is|it|ja|kk|kn|ko|lt|lv|mi|mk|mr|ms|ne|nl|nr|pl|pt|ro|ru|sk|sl|sr|sv|sw|ta|th|tl|tr|uk|ur|vi|zh/ do
    resources :monologues
    resources :conversations
    #root "home#index"
    root "monologues#new"    
  end
end