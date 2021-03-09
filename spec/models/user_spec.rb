require 'rails_helper'

RSpec.describe User, type: :model do
  before do

    @user = User.new(
      first_name: "something",
      last_name: "something",
      email: "example@gmail.com",
      password: "example123",
      password_confirmation: "example123"
    )

  end

  describe "Validations" do

    it "should not be valid without a password" do
      user = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: ""
      )

      user.save

      expect(user).to_not be_valid
    end

    it "both password fields match" do
      expect(@user.password).to eql(@user.password_confirmation)
    end

    it 'should have a unique email' do
      user = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: "example123"
      )

      user.save

      user1 = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: "example123"
      )

      user1.save

      expect(user1).to_not be_valid
    end

    it "should not be valid without first name" do
      @user.first_name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not be valid without last name" do
      @user.last_name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not be valid without email" do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should have a password length of at least 6' do
      user1 = User.new(      
        first_name: "Anything",
        last_name: "Anything",
        email: "CHRISTOPHERJKANG24@GMAIL.COM",
        password: "tango",
        password_confirmation: "tango"
      )
      user1.save 
      expect(user1).to_not be_valid
    end 
  end

  describe '.authenticate_with_credentials' do
    it "should login if credentials are valid" do
      user = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: "example123"
      )

      user.save
      
      new_user = User.authenticate_with_credentials(user.email, user.password)

      expect(new_user).to eql(user)
    end

    it "should login with leading/trailing whitespaces" do
      user = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: "example123"
      )

      user.save
      
      new_user = User.authenticate_with_credentials(" example@gmail.com  ", "example123")

      expect(new_user).to eql(user)
    end

    it "should be case insensitive for login" do 
      user = User.new(
        first_name: "something",
        last_name: "something",
        email: "example@gmail.com",
        password: "example123",
        password_confirmation: "example123"
      )

      user.save

      new_user = User.authenticate_with_credentials(" EXAMPLE@GMAIL.COM  ", "example123")

      expect(new_user).to eql(user)
    end
  end
end
