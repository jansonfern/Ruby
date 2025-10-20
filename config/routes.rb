Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Root routes within Devise scope
  devise_scope :user do
    unauthenticated do
      root to: 'users/sessions#new', as: :unauthenticated_root
    end
    authenticated :user do
      root to: 'home#index', as: :authenticated_root
    end
  end

  # Questionnaires routes with shallow nesting
  resources :questionnaires do
    member do
      get :take
      post :submit
      get :results
    end

    resources :questions, shallow: true do
      resources :question_options, shallow: true
    end
  end

  # User results routes
  resources :user_results, only: [:index, :show, :destroy]

  # Admin routes
  scope :admin do
    get "dashboard", to: "admin#dashboard", as: :admin_dashboard
    get "users", to: "admin#users", as: :admin_users
    delete "users/:id", to: "admin#destroy_user", as: :admin_destroy_user
    get "questionnaires", to: "admin#questionnaires", as: :admin_questionnaires
  end

  # Admin signup routes
  get "admin/signup", to: "admin_signup#new", as: :admin_signup
  post "admin/signup", to: "admin_signup#create"

  # Legacy quiz routes
  get "quiz/:id/take", to: "quiz#take", as: :take_quiz
  post "quiz/:id/submit", to: "quiz#submit", as: :submit_quiz
  get "quiz/:id/results", to: "quiz#results", as: :quiz_results
  get "quiz/test_debug", to: "quiz#test_debug", as: :quiz_test_debug
  get "quiz/test_submit", to: "quiz#test_submit", as: :quiz_test_submit
end
