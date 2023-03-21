class Ability
  include CanCan::Ability
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    if user.hr?
      can :manage, :all
    elsif user.manager?
      can :create, :shift_allocations
      can :read, Employee, id: user.id
      can :manage, Employee, manager_id: user.id # make sure the ids of employees and users match!!!
    else
      can :read, Employee, id: user.id # self
    end
  end
end
