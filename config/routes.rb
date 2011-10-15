Foodlobby::Application.routes.draw do
  devise_for :users

  resources :members

  match 'transactions(.:format)', :controller => :transactions, :action => :all_households, :as => :all_transactions

  match 'test_exception', :controller => :test_exception, :action => :test_exception

  resources :households do
    resources :transactions
  end

  root :to => "households#index"

end
