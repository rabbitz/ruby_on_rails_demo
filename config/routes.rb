Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "events#index"
  match ':controller(/:action(/:id(.:format)))', :via => :all
end
