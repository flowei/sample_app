# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  
  before(:each) do
      @attr = {
        :name => "Example user",
        :email => "user@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
      }
  end
  
  it "should cerate a new instance with valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    bad_guy = User.new(@attr.merge(:name => ""))
    bad_guy.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject too long names" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject not valid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject an already existant email" do
    # Creation user en DB
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject an already existant email to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "it should reject too short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject too long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should define encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "method has_password?" do
      
      it "should return true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should return false if passwords not match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      
      it "should return nil if email/password not match" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil if an email doesn't match any user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
        end

      it "should return the user if email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
    
  end
  
end
