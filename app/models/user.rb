class User < ActiveRecord::Base
  attr_accessor :confirm_pw

  has_secure_password
  has_many :event_comments, through: :comments, source: :event, dependent: :destroy
  has_many :event_attendees
  has_many :attending, source: :event, through: :event_attendees

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :state, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, on: :create

  validate :password_matcher

  protected
    def password_matcher
      if self.password != self.confirm_pw
        errors.add(:confirm_pw, "Passwords do not match.")
      end
    end
end
