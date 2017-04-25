Rails.application.routes.draw do

  root to: 'static_pages#about'
  devise_scope :student do
    get "sign_in", :to => "students/sessions#new"
    get 'students/sign_out', :to =>"devise/sessions#destroy"
  end
  devise_scope :teacher do
    get "sign_in", :to => "teachers/sessions#new"
    get 'teachers/sign_out', :to =>"devise/sessions#destroy"
  end
  get 'about', to: "static_pages#about", as: "contacto"
  #get 'home', to: "static_pages#home", as: "home"

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
  devise_for :students
  devise_for :teachers
  resources :students
  resources :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
