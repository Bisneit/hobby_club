# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'groups#index'

  resources :users
  resources :posts
  resources :events
  resources :groups do
    scope module: :groups do
      resources :participants, controller: :participants
    end
  end
end
