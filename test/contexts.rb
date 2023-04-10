def create_users
  @user1 = User.create(username: 'mashael', password: 'password123', password_confirmation: 'password123')
  @user2 = User.create(username: 'hessa', password: 'password123', password_confirmation: 'password123')
  @user3 = User.create(username: 'fatima', password: 'password123', password_confirmation: 'password123')
  @user4 = User.create(username: 'noor', password: 'password123', password_confirmation: 'password123')
end

def create_locations
  @location1 = Location.create(name: 'AlWaab', address: 'XYZ Street')
  @location2 = Location.create(name: 'AlSadd', address: 'ABC Street')
end

def create_employees
  Employee.create([
                   { card_num: '41368', first_name: 'Mashael', last_name: 'Alemadi', email: 'malemadi19@gmail.com', phone: '50082008',
                     role: :employee, user_id: @user1.id },
                   { card_num: '40534', first_name: 'Hessa', last_name: 'Boday', email: 'hessaboday1@gmail.com', phone: nil, role: :manager,
                     user_id: @user2.id },
                   { card_num: '41337', first_name: 'Fatima', last_name: 'AlSafar', email: 'fsafar@andrew.cmu.edu', phone: nil, role: :hr,
                     user_id: @user3.id },
                   { card_num: '99999', first_name: 'Noor', last_name: 'AlTamimi', email: 'naltamim@andrew.cmu.edu', phone: nil, role: :employee,
                     user_id: @user4.id }
                 ])
  @m = Employee.first
  @h = Employee.second
  @f = Employee.third
  @n = Employee.fourth

  @m.update(manager_id: @h.id)
  @n.update(manager_id: @h.id)

end

def destroy_employees
  @m.destroy
  @n.destroy
  @h.destroy
  @f.destroy
end

def destroy_locations
  @location1.destroy
  @location2.destroy
end

def destroy_users
  @user1.destroy
  @user2.destroy
  @user3.destroy
  @user4.destroy
end

def create_all
  create_users
  create_employees
  create_locations
end

def destroy_all
  destroy_locations
  destroy_employees
  destroy_users
end