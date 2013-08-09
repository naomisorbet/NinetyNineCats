require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :password
  validates :username, uniqueness: :true
  before_create :hash_password

  def give_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def validate_password(input)
    self.class.hash_text(input) == self.password
  end

  private
  def hash_password
    self.password = self.class.hash_text(password)
  end

  def self.hash_text(text)
   Digest::SHA1.hexdigest(text)
  end
end
