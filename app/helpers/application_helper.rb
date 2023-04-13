module ApplicationHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    # reset_session
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end


  ###############

    def sidebar_links_partial
      if current_user.manager? || current_user.hr?
        'shared/manager_sidebar_links'
      else
        'shared/employee_sidebar_links'
      end
    end

    def notifications
      if current_user.hr?
        ['Noor AlTamimi clocked-in late today.', 'Mashael AlEmadi clocked-in from unassigned location.', 'Hessa Boday clocked-out early today.', 'Fatima Alsafar has worked overtime today.']
      elsif current_user.manager?
        ['Noor AlTamimi clocked-in late today.', 'Mashael AlEmadi clocked-in from unassigned location.']
      else
        ['You have used ' + current_user.employee.grace_time_used_in_current_month + ' of your grace time for this month.', 'You clocked in 37 mintues late today', 'You attempted clocking in from unauthorized location on April 5']
      end
    end



  
end
