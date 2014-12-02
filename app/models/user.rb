# An administrative account. The default devise user model has been modified.
class User < ActiveRecord::Base
  include Role
  has_many :user_consents
  has_many :sites_users
  has_one :user_screening_flag

  attr_accessor :participant, :status, :site_id

  validates :first_name, presence: true, allow_blank: false, allow_nil: false
  validates :last_name, presence: true, allow_blank: false, allow_nil: false
  validate :phone_format_validator

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def password_required?
    super if confirmed?
  end

  def password_match?
    errors[:password] <<
      'can\'t be blank' if password.blank?
    errors[:password_confirmation] <<
      'can\'t be blank' if password_confirmation.blank?
    errors[:password_confirmation] <<
      'does not match password' if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def role_identifier_enum
    [
      %w(Super\ User 1),
      %w(Admin 2),
      %w(Content\ Manager 3),
      %w(Participant 4)
    ]
  end

  private

  def phone_format_validator
    return if phone.blank?

    number = phone.tr('^0-9', '')
    return if number.length == 10 || number.length == 11

    errors.add(:phone, 'Phone number is not valid. Please include area code ' \
                       'and seven digit number: (xxx-xxx-xxxx)')
  end
end
