# frozen_string_literal: true

Rails.application.routes.draw do
  root "root#index"
  get 'terms', to: "root#terms"
  get 'privacy', to: "root#privacy"
end
