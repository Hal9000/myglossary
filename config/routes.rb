Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  get '/words/:id/claim_word', to: 'words#claim', as: 'claim_word'

  resources :words do
    member do
      post "claim"
      post "unclaim"
      post "draft"
      post "completed"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"

end
