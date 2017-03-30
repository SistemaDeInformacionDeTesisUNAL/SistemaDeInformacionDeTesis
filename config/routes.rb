Rails.application.routes.draw do

  root to: 'static_pages#home'

  get 'about', to: "static_pages#about", as: "contacto"
  get 'home', to: "static_pages#home", as: "home"

  resources :tag_investigation_groups
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
  mount_devise_token_auth_for 'Student', at: 'student_auth'

  mount_devise_token_auth_for 'Teacher', at: 'teacher_auth'
  as :teacher do
    # Define routes for Teacher within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
