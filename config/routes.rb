Rails.application.routes.draw do
  devise_for :users

  post '/words/:id/claim_word', to: 'words#claim', as: 'claim_word'

  resources :words
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
