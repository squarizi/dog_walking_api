Rails.application.routes.draw do
  namespace :v1 do
    resources :dogs_walking, only: [:show, :index, :create] do
      put :start_walking
      put :finish_walking
    end
  end
end
