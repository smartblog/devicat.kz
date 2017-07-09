Rails.application.routes.draw do
  devise_for :users

  concern :votable do
    patch :vote, on: :member
  end

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
      concerns :votable
    end
  end

  resources :attachments, only: [:destroy]

  root to: "questions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
