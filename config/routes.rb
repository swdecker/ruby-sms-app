Rails.application.routes.draw do
  resources :sms_messages
  post '/inbound_sms', to: 'sms_messages#response'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
