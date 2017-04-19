Rails.application.routes.draw do

  root to: 'static_pages#about'

  #Redireccion del boton de deslogearse
  get 'Log out', to: "students#sing_in", as: "login"

  get 'about', to: "static_pages#about", as: "contacto"
  #get 'home', to: "static_pages#home", as: "home"
  

  get 'teacher', to: "teachers#show", as: "teacher"

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
