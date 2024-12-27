require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a valid details" do
    user = User.new({ first_name: 'John', last_name: 'Doe', email: 'johndoe@example.com', password: 'password' })
    expect(user).to be_valid
  end

  it "is invalid without a first_name" do
    user = User.new({ last_name: 'Doe', email: 'johndoe@example.com', password: 'password' })
    expect(user).to_not be_valid
  end
end
