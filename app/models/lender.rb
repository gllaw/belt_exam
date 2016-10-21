class Lender < ActiveRecord::Base
  has_secure_password
  has_many :histories
  
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: {minimum: 2}
  validates :money, presence: true, numericality: { only_float: true}
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save do 
  	self.first_name.capitalize!
  	self.last_name.capitalize!
  	self.email.downcase!
  end

  # def your_people
  # end

end