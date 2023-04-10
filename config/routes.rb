Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :password_resets, only: [:new, :create, :edit, :update]
  get 'calendar', to: 'calendar#show', as: :calendar
  get 'shift_assignments/edit'
  get 'static/reports'
  # resources :posts
  # get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :employees, only: [:show]

  #resources :shift_assignments do
  #  put 'amend', on: :member
  #end
  patch '/amend', to: "shift_assignments#edit", as: :amend


  get 'clock/:id', to: 'clock_in#clock_in_out'

  # get 'test/v1' # nicer looking login for employees
  # get 'test/v2' # same as 'clock_in_out'
  # get 'test/v3' # navbar

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


  ############################ testing
  get '/w1', to:'test#w1'

end
