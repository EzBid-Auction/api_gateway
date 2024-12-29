class UserResource < JSONAPI::Resource
  attributes :first_name, :last_name, :phone_number, :phone_country_code, :email, :password, :password_confirmation
end
