class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :histories
  has_many :lenders, through: :histories
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :money, :purpose, :description, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :purpose, length: { minimum: 4 }
  validates :description, length: { minimum: 10 }
end
