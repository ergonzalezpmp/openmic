class User < ApplicationRecord
  has_many :user_events
  validates :password, presence: true, length: { minimum: 6 }

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password


  def self.create_from_google(auth)
    User.create!(
      google_id: auth['uid'],
      email: auth['info']['email'],
      password: '123456'
    )
  end

  def self.create_from_facebook(auth)
    User.create!(
      facebook_id: auth['uid'],
      email: auth['info']['email'],
      password: '123456'
    )
  end
end
