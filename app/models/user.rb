class User < ApplicationRecord
  has_one :employee

  USERNAME_REGEX = /\A[a-zA-Z][a-zA-Z0-9]+\z/
  has_secure_password
  validates :username, presence: true,
                       length: { minimum: 3, maximum: 12 }, # validates that the username is between 3 and 12 characters
                       format: { with: USERNAME_REGEX }, # ensures that the username starts with a letter and only contains digits and letters
                       uniqueness: { case_sensitive: false }
  before_save { username.downcase! }

  validates :password, presence: true, length: { minimum: 8 } # validates that the password is at least 8 characters 

  def role?(auth_role) # checks whether the user has the requested role
    # debugger
    return false if employee.nil? 
    employee.role.to_sym == auth_role
  end

  def hr? # returns true if the user is an HR admin, and false otherwise
    role? :hr
  end

  def manager? # returns true if the user is a manager, and false otherwise
    role? :manager
  end

  def employee? # returns true if the user is an employee, and false otherwise
    role? :employee
  end

  def create_password_reset_token
    raw_token = SecureRandom.urlsafe_base64
    self.password_reset_token = Digest::SHA256.hexdigest(raw_token)
    self.password_reset_sent_at = Time.zone.now
    update_columns(password_reset_token: password_reset_token, password_reset_sent_at: password_reset_sent_at)
    raw_token
end


  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    #debugger
    digest = self.send("#{attribute}_token")
    return false if digest.nil?
    digest == Digest::SHA256.hexdigest(token)
  end

  def clear_password_reset_token
    update_columns(password_reset_token: nil, password_reset_sent_at: nil)
  end


end
