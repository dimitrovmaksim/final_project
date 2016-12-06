class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :articles
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates :password, presence: true, :on => :create, length: { in: 6..20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..20 }

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
