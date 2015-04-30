Rails.application.routes.draw do
  resources :user_vacancies

  resources :vacancies

  resources :occupations

  resources :projects

  resources :jobs

  resources :analytics

  devise_for :users

  resources :users, only: [:show]

  devise_scope :user do
    authenticated :user do
      root :to => 'projects#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :vacancies do
    post 'apply', on: :member
  end

  resources :user_vacancies do
    post 'approve', on: :member
  end

  resources :user_vacancies do
    post 'disapprove', on: :member
  end

end