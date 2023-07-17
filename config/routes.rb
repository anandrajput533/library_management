Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :books
      resources :libraries
      devise_scope :user do
        post "users/sign_up", to: "registrations#create"
        post "users/sign_in", to: "sessions#login"
        post "users/sign_out", to: "sessions#logout"
      end
      get "/search", to: "books#search_book"
      get "/book_issued", to: "books#book_issued"
    end
  end
end
