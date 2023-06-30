# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "root#index"
  get 'terms', to: "root#terms"
  get 'privacy', to: "root#privacy"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
