Citydogshare::Application.routes.draw do
    get '/login', to: 'sessions#handle_login', as:'login'
    get '/signup', to: 'sessions#handle_signup', as:'signup'
    get 'auth/:provider/callback', to: 'sessions#handle_auth', as: 'auth'
    get 'auth/failure', to: 'sessions#handle_failure', as: 'failure'
    get 'signout', to: 'sessions#destroy', as: 'signout'

    resources :sessions, only: [:create, :destroy]
    resources :user

end
