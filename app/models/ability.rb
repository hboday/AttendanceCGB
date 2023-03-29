class Ability
  include CanCan::Ability
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    if user.hr?
      can :manage, :all
        # If the user has an HR role, they can manage everything on the system.
    
      elsif user.manager?
      can :create, :shift_allocations
      can :read, Employee, id: user.id
      can :manage, Employee, manager_id: user.id # make sure the ids of employees and users match
          # If the user is a manager, they can create shift allocations and they can read their 
          # own page and they can manage their own employees.

    else
      can :read, Employee, id: user.id # self - regular employees can only view their own information.
    end
  end
end
