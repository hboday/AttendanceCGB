require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:shift_assignments)
  should have_many(:shifts).through(:shift_assignments)

  should validate_presence_of(:role)
  should define_enum_for(:role).with_values(%i[employee manager hr])

  context "with gravatar" do
    setup do
      create_users
      create_employees
    end

    should "have a gravatar URL" do
      employee = FactoryBot.create(:employee, email: "test@example.com", 
        user:FactoryBot.create(:user, username:"testing"))
      assert_equal "55502f40dc8b7c769880b10874abc9d0", employee.email_gravatar.split('/').last
      employee.destroy!
    end

    should "find employee by card number" do
      employee = Employee.with_card("41368")
      assert_equal "Mashael", employee.first_name
      assert_equal "Alemadi", employee.last_name
    end

    should "return employees managed by a manager" do
      employees = @h.managed_employees
      assert_equal 2, employees.count
      assert_includes employees, @m
      assert_includes employees, @n
      refute_includes employees, @h
      refute_includes employees, @f
    end

    should "return humanized role name" do
      assert_equal "Employee", @m.humanized_role
      assert_equal "Manager", @h.humanized_role
      assert_equal "Human Resources", @f.humanized_role
    end

    

  end
end
