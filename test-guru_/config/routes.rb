Rails.application.routes.draw do
  root to: 'tests#index'
  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout },
    controllers: { sessions: 'sessions', registrations: 'registrations' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tests, only: :index do
    post :start, on: :member
  end

  resources :test_passages, only: [:show, :update] do
    member do
      get :result
      post :gist
    end
  end

  resources :badges, only: :index

  namespace :admin do
    resources :gists, only: :index
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :badges
  end
end
