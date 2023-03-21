Rails.application.routes.draw do
  get 'static/reports'
  resources :posts
  # get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :employees, only: [:show]

  #resources :shift_assignments do
  #  put 'amend', on: :member
  #end
  get '/amend', to: "shift_assignments#edit", as: :amend

  # get 'employees/index'
  # get 'employees/show'
  # remove

  get 'clock', to: 'test#v2'
  get 'test/v1'
  get 'test/v2'
  get 'test/v3'
  get 'test/v4'
  get 'test/v5'
  get 'test/tabs'
  # end remove
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  post 'process', to: 'attendance#proc' # remove??

  root 'sessions#new'

  # allocate employee shifts to system (POST from managers' form)
  post '/sa', to: 'attendance#shift_allocate'

  get 'alloc_form', to: 'attendance#allocate' # instead of shift/new

  get '/reports', to: 'static#reports'
end
