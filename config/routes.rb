Rails.application.routes.draw do

  # match '*path' => 'application#cors', via: :options,
  #   constraints: CORS::RouteConstraint.new

  # root to: proc {
  #   [ 200, Rails.application.config.action_dispatch.default_headers, [ '' ] ]
  # }
  scope constraints: { format: :json }, defaults: { format: :json } do
    resources :videos, only: [:index, :show, :create, :update] do
      resources :views, only: [:create]
    end
    resources :views, only: [:index]
  end
    
end



