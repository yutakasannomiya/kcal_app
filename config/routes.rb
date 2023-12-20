Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles
  # asオプションはplefixを生成する
  get 'checks/:id', to: 'checks#check', as: 'check'
end
