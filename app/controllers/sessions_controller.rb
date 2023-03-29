class SessionsController < ApplicationController
  def new # displays the login form
    # render 'new', layout: false
    #  render 'newb', layout: true
  end

  # when a user logs in, the system esablishes a new session for them that lasts until they logout
  def create # authenticates who the user is 
    uname = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by(username: uname)
    # debugger
    if user && user.authenticate(password)
      log_in user
      redirect_to employee_path(user.employee) # different from tut (his more general)
    else
      # flash error, how to render?
      flash.now[:danger] = 'Invalid...'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy # destroys the session when the user logs out and redirects them to the login page
    log_out
    redirect_to login_path
  end
end
