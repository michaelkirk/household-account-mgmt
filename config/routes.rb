Foodlobby::Application.routes.draw do
  devise_for :users

  resources :members

  match 'transactions(.:format)', :controller => :transactions, :action => :all_households, :as => :all_transactions

  resources :households do
    resources :transactions
  end

  root :to => "households#index"

end
