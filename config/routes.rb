ChessCamp::Application.routes.draw do
  get "user/new"
  get "user/create"
  get "user/update"
  get "user/edit"
  get "user/destroy"
  get "user/index"
  get "user/show"
  get "student/new"
  get "student/create"
  get "student/update"
  get "student/edit"
  get "student/destroy"
  get "student/index"
  get "student/show"
  get "registration/new"
  get "registration/create"
  get "registration/update"
  get "registration/edit"
  get "registration/destroy"
  get "registration/index"
  get "registration/show"
  get "family/new"
  get "family/create"
  get "family/update"
  get "family/edit"
  get "family/destroy"
  get "family/index"
  get "family/show"
  get "location/new"
  get "location/create"
  get "location/update"
  get "location/edit"
  get "location/destroy"
  get "location/index"
  get "location/show"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
