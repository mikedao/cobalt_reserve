class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, allow_blank: true

  has_secure_password

  has_many :characters

  default_scope { order :id }

  enum role: %w[default admin]

  def active_campaign_character
    current_campaign = Campaign.current
    characters.where(campaign: current_campaign, active: true).first unless current_campaign.nil?
  end

  def status
    if active
      'Active'
    else
      'Inactive'
    end
  end
end
