class SessionsController < ApplicationController
  def new
    # render 'new', layout: false
    render 'newb', layout: true
  end

  def create
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

  def destroy
    log_out
    redirect_to root_url
  end
end
