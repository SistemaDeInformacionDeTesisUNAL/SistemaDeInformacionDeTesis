Rails.application.routes.draw do

#  root to: "home#index"
  root to: 'static_pages#home'

  get 'about', to: "static_pages#about", as: "contacto"
  get 'home', to: "static_pages#home", as: "home"
  resources :tag_contributions
  resources :tags
  resources :ubications
  resources :user_contributions
  resources :contributions
  resources :history_groups
  resources :event_teachers
  resources :event_students
  resources :events
  resources :profiles
  resources :teacher_investigation_groups
  resources :investigation_groups
  devise_for :teachers
  devise_for :students
  resources :students
  resources :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
