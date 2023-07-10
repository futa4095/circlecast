# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups do
    resources :channels, only: [:index], controller: "groups/channels"
  end
  resources :channels, except: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  root "root#index"
  get 'terms', to: "root#terms"
  get 'privacy', to: "root#privacy"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
