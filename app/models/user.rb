class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, allow_blank: true

  has_secure_password

  has_many :characters
  has_many :adventure_logs

  enum role: %w(default admin)

  def active_campaign_character
    characters.where(campaign: Campaign.current, active: true)
  end
end
