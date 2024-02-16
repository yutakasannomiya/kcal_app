Rails.application.routes.draw do
  devise_for :users 
  devise_scope :user do
    resources :calcs, only: [:index, :new, :create]
  end
  root to: 'articles#index'
  
  resources :articles
  get '/calcs/calc', to: 'calcs#calc'
  
  # asオプションはplefixを生成する
  get 'checks/:id', to: 'checks#check', as: 'check'
end
