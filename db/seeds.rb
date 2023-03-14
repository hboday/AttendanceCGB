# Shift.create!([
#   {start_time: "2023-02-16 19:08:05", end_time: "2023-02-17 03:08:05"},
#   {start_time: "2023-02-18 16:50:54", end_time: "2023-02-18 20:50:54"}
#
# ])

user1 = User.create!(username: 'mashael', password: 'password123', password_confirmation: 'password123')
user2 = User.create!(username: 'hessa', password: 'password123', password_confirmation: 'password123')
user3 = User.create!(username: 'fatima', password: 'password123', password_confirmation: 'password123')
user4 = User.create!(username: 'noor', password: 'password123', password_confirmation: 'password123')

Location.create!([
                   { name: 'AlWaab', address: 'XYZ Street' },
                   { name: 'AlSadd', address: 'ABC Street' }
                 ])

Employee.create!([
                   { card_num: '12345', first_name: 'Mashael', last_name: 'Alemadi', email: 'malemadi19@gmail.com', phone: '50082008',
                     role: :employee, user_id: user1.id },
                   { card_num: '40534', first_name: 'Hessa', last_name: 'Boday', email: 'hessaboday1@gmail.com', phone: nil, role: :manager,
                     user_id: user2.id },
                   { card_num: '41337', first_name: 'Fatima', last_name: 'AlSafar', email: 'fsafar@andrew.cmu.edu', phone: nil, role: :hr,
                     user_id: user3.id },
                   { card_num: '99999', first_name: 'Noor', last_name: 'AlTamimi', email: 'naltamim@andrew.cmu.edu', phone: nil, role: :employee,
                     user_id: user4.id }
                 ])

m = Employee.first
h = Employee.second
f = Employee.third
n = Employee.fourth

m.manager_id = h.id
n.manager_id = h.id
m.save!
n.save!

ShiftAssignment.delete_all
Shift.delete_all

Shift.create_shifts("2023-03-01", "2023-03-12", "10:00", "18:00", 1)

s_ids = Shift.all.map {|s| s.id}
e_ids = [1, 4]

ShiftAssignment.create_shift_assignments(s_ids, e_ids)

ShiftAssignment.all.each do |a|
	t1 = a.shift.start_time
	t2 = a.shift.end_time
	r1 = t1 + (rand(20)-10).minutes
	r2 = t2 + (rand(20)-10).minutes
	a.clockin_time = r1
	a.clockout_time = r2
	a.save!
end




# ShiftAssignment.create!([
#   {employee_id: 1, shift_id: 1, clockin_time: "2023-02-18 18:57:54", clockout_time: "2023-02-18 18:58:00"},
#   {employee_id: 1, shift_id: 2, clockin_time: "2023-02-16 19:09:02", clockout_time: "2023-02-17 03:09:02"},
#   {employee_id: 2, shift_id: 2, clockin_time: "2023-02-16 20:09:45", clockout_time: "2023-02-17 02:09:45"}
# ])
