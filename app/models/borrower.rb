class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :histories
  
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: {minimum: 2}
  validates :money, numericality: { only_float: true}
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :purpose, presence: true
  validates :description, presence: true, length: {maximum: 500}

  before_save do 
  	self.first_name.capitalize!
  	self.last_name.capitalize!
  	self.email.downcase!
  end

end