ChessCamp::Application.routes.draw do

  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :families
  resources :students
  resources :locations
  resources :users
  resources :registrations
  resources :sessions



  # Authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'signup' => 'users#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login
  get 'user/search', to: 'users#search', as: :search
  get 'payment_reports', to: 'users#payment_reports', as: :payment_reports
  get 'registered_students', to: 'users#registered_students', as: :registered_students
  
  #get 'family/family_payment', to: 'families#family_payment', as: :family_payment

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  
  get 'show_deposit'  => 'users#show_deposit', as: :show_deposit
  get 'show_full'  => 'users#show_full', as: :show_full
  get 'show_instructors'  => 'users#show_instructors', as: :show_instructors


  # set the root url
  root :to => 'home#index'  

  resources :families do
    member do
      post :family_payment
    end
  end

end
