class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_authentication_token

  has_many :picks, dependent: :destroy

  validate :validate_teams_count
  validates :email, uniqueness: {case_sensitive: false}

  has_and_belongs_to_many :teams

  TOURNEY_START_TIME = Time.zone.local(2015, 3, 19, 11, 45)

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def can_select_teams
    Time.zone.now < TOURNEY_START_TIME
  end

  private

  def validate_teams_count
    if teams.count > 3
      errors.add(:base, 'cannot have more than 3 teams')
      return false
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
