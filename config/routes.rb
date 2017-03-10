Rails.application.routes.draw do
  resources :posts
  resources :categories

  resources :home do
    collection do
      get 'about'
    end
  end

  root :to => "home#index"
end
