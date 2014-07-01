require 'spec_helper'

describe "Users" do
  
  describe "sign up" do

      describe "fail" do

        it "should not create new user" do
          lambda do
            visit signup_path
            fill_in "Name",         :with => ""
            fill_in "Email",        :with => ""
            fill_in "PAssword",     :with => ""
            fill_in "Confirmation", :with => ""
            click_button
            response.should render_template('users/new')
            response.should have_selector("div#error_explanation")
          end.should_not change(User, :count)
        end
      end
    
    
    describe "succes" do
      it "should create new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Example User"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success", :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "Sign in/Sign out" do
    
    describe "fail" do
        
      it "should not sign in user" do
        visit signin_path
        fill_in "eMail", :with => ""
        fill_in "password", :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end
    
    describe "success" do
      
      it "should sign in user then sign out" do
        user = FactoryGirl.create(:user)
        visit signin_path
        fill_in "eMail", :with => user.email
        fill_in "password", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
      
    end
    
    
  end
end
