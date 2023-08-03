# frozen_string_literal: true

Rails.application.routes.draw do
  get 'invitations/:token',to: 'invitations#show', as: :invitations
  resources :groups do
    resources :channels, except: [:show]
    resources :members, only: [:index, :update], controller: "groups/members"
  end
  resources :channels, only: [:show] do
    resources :episodes, except: [:index]
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  root "root#index"
  get 'terms', to: "root#terms"
  get 'privacy', to: "root#privacy"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
