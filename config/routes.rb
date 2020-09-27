Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "households#index"

  devise_for :users

  resources :members

  get 'transactions(.:format)', :controller => :transactions, :action => :all_households, :as => :all_transactions
  get 'monthly_reports', :controller => :monthly_reports, :action => :index, :as => 'monthly_reports'
  get 'test_exception', :controller => :test_exception, :action => :test_exception

  resources :households do
    resources :transactions
  end

end
