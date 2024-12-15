class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :sanitize_phone
  normalizes :phone_number, with: ->(phone) { phone.delete("^0-9").delete_prefix("0") }

  def self.authenticate!(username, password)
    user = User.find_by(email: username) || User.find_by(phone_number: username)
    user if user.valid_password?(password)
  end

  def sanitize_phone
    phone_number.delete("^0-9").delete_prefix("0")
  end

  def international_phone_number
    phone_country_code + phone_number
  end
end
