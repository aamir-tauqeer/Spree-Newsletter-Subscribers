Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :newsletter_subscribers
  end
  resources :newsletter_subscribers do
    collection do
      get "confirm/:key", action: 'confirm'
      get "unsubscribe/:key", action: 'unsubscribe'
    end
  end
end
