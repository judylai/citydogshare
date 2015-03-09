Citydogshare::Application.routes.draw do
    get 'auth/:provider/callback', to: 'sessions#handle_auth'
    get 'auth/failure', to: 'sessions#handle_failure'
    get 'signout', to: 'sessions#destroy', as: 'signout'

    resources :users
   
    root :to => 'welcome#index'

end
