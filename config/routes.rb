Rails.application.routes.draw do
  root 'welcome#start'
  get 'welcome/index'
  get 'welcome/start'
  post 'welcome/enter'
  post 'welcome/initial'
  post 'welcome/steal'
  post 'welcome/swap'
  post 'welcome/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
