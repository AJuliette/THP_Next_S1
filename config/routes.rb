# frozen_string_literal: true

Rails.application.routes.draw do
  root 'administration/items#index'

  get '/home', to: 'home#landing_page'

  get 'send_offer/create', to: 'sendoffer#create'

  namespace 'administration' do
    get '/', to: 'items#index'

    resources :items
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  devise_for :admin, controllers: {
    sessions: 'admins/sessions',
    confirmations: 'admins/confirmations',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
    unlocks: 'admins/unlocks'
  }
end
