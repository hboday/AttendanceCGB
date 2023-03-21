class User < ApplicationRecord
  has_one :employee

  USERNAME_REGEX = /\A[a-zA-Z][a-zA-Z0-9]+\z/
  has_secure_password
  validates :username, presence: true,
                       length: { minimum: 3, maximum: 12 },
                       format: { with: USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }
  before_save { username.downcase! }

  validates :password, presence: true, length: { minimum: 8 }

  def role?(auth_role)
    # debugger
    return false if employee.nil?
    employee.role.to_sym == auth_role
  end

  def hr?
    role? :hr
  end

  def manager?
    role? :manager
  end

  def employee?
    role? :employee
  end
end
