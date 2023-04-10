class User < ApplicationRecord
	has_many :twitter_accounts
	has_many :tweets
	has_secure_password
	validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
	validates :password, :password_confirmation, presence: true
	validates_uniqueness_of :email
end
