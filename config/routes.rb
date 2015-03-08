Citydogshare::Application.routes.draw do
    get '/login', to: 'sessions#login', as:'login'
    get '/signup', to: 'sessions#signup', as:'signup'
    get 'auth/:provider/callback', to: 'sessions#handle_auth'
    get 'auth/failure', to: 'sessions#handle_failure'
    get 'signout', to: 'sessions#destroy', as: 'signout'

    resources :sessions, only: [:create, :destroy]
    resources :user

end
