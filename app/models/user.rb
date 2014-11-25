class User < ActiveRecord::Base

  include BCrypt

  validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates :password, length: { minimum: 6 }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate pass
    self.password == pass
  end
end
