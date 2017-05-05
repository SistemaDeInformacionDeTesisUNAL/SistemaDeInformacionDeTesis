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

  #Post the subscription to our app
  post "/subscribe" => "subscriptions#create"
  delete "/unsubscribe" => "subscriptions#destroy"

  #Push notification
  post "/push" => "push_notifications#create"


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
  resources :investigation_groups do
    collection do
      get  ':id/member',              to: "investigation_groups#member",                    as: "member"
      post ':id/member/state',        to: "investigation_groups#updateMemberState",         as: "updateMemberState"
      post ':id/member/rol',          to: "investigation_groups#updateMemberRol",           as: "updateMemberRol"
      get  ':id/join',                to: "investigation_groups#join",                      as: "join"
      get  ':id/contributionsGroup',  to: "investigation_groups#contributionsGroup",        as: "contributionsGroup"
      post ':id/contributions/state', to: "investigation_groups#updateContributionState",   as: "updateContributionState"
    end 
    resources :contributions, only:[:new,:create,:show]
  end
  devise_for :students
  devise_for :teachers
  resources :students, except:[:new,:create]
  resources :teachers, except:[:new,:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
