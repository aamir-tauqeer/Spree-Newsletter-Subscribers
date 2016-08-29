Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :newsletter_subscribers do
      collection do
        get "write_email"
        post "send_email"
      end
    end
  end

  resources :newsletter_subscribers do
    collection do
      get "confirm/:key", action: 'confirm'
      get "unsubscribe/:key", action: 'unsubscribe'
    end
  end
end
