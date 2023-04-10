require "test_helper"

class UserTest < ActiveSupport::TestCase
  should  have_secure_password
  should validate_presence_of(:username)
  

  
  context "Creating users context" do
    setup do
      create_users
      create_employees
    end
    teardown do
      destroy_employees
      destroy_users
    end

    should "check username is as expected" do
    assert_equal "mashael", @user1.username
    end

    should "check password not stored" do
      u = User.first
      
      assert_nil u.password
      assert_nil u.password_confirmation
      
    end

    should "check password and confirmation must match" do
      u1 = User.new(username:  "abc",  password: "12345678", password_confirmation:  "12345678")
      assert u1.valid?
       u2 = User.new(username:  "abc",  password: "12345678", password_confirmation:  "12345670")
       deny u2.valid?
    end

    should "check password length is at least 8 characters" do
      assert User.new(username:  "abc",  password: "12345678", password_confirmation:  "12345678").valid?
      deny User.new(username:  "abc",  password: "1234567", password_confirmation:  "1234567").valid?
      
    end


    should "check username should have min and max length of username enforced" do
      u = FactoryBot.build(:user, username:"po")
      deny u.valid?
      u =  FactoryBot.build(:user, username:"potato")
      assert u.valid?
      u = FactoryBot.build(:user, username:"potatosalad123")
      deny u.valid?
    end

    should "check username regex syntax is enforced" do
      deny FactoryBot.build(:user, username:"1fatima").valid?
      deny FactoryBot.build(:user, username:"fatima!").valid?
      assert FactoryBot.build(:user, username:"fatima1").valid?
      
    end

    should  "check username is lower-cased before saving" do
      u = FactoryBot.build(:user, username:"JoHn")
      assert_equal "JoHn", u.username
      u.save!
      u.reload
      assert_equal "john", u.username
    end

    should "check username is unique" do
      u = FactoryBot.build(:user, username:"mashael")
      deny u.valid?
      u = FactoryBot.build(:user, username:"mashael1")
      assert u.valid?
    end

    should "check role of corresponding employee" do
      assert @user1.employee?
      assert @user2.manager?
      assert @user3.hr?
      assert @user4.employee?
    end

    should "check password reset token creation and reset" do
      assert_nil @user1.password_reset_token
      assert_nil @user1.password_reset_sent_at
      @user1.create_password_reset_token
      assert @user1.password_reset_token.present?
      assert @user1.password_reset_sent_at.present?
      assert_in_delta Time.current, @user1.password_reset_sent_at, 1
      @user1.clear_password_reset_token
      assert_nil @user1.password_reset_token
      assert_nil @user1.password_reset_sent_at
    end


  end

end
