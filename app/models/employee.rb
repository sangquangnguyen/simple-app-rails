class Employee < ApplicationRecord
  include BCrypt
  belongs_to :organisation

  enum role: { system: 'system', admin: 'admin', employee: 'employee' }
  validates :avatar, :fname, :lname, :birthday, :role, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  def password
    @password ||= Password.new(password_hash) unless password_hash.to_s.strip.empty?
  end

  def password=(new_password)
    unless new_password.to_s.strip.empty?
      @password = Password.create(new_password)
      self.password_hash = @password
    end
  end
end
