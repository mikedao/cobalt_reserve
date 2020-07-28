class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, allow_blank: true

  has_secure_password

  has_many :characters

  def admin?
    status == 'admin'
  end
end
