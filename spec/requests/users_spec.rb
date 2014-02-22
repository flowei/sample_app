require 'spec_helper'

describe "Users" do
  describe "une inscription" do

      describe "ratée" do

        it "ne devrait pas créer un nouvel utilisateur" do
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
    end
    
    describe "réussie" do

          it "devrait créer un nouvel utilisateur" do
            lambda do
              visit signup_path
              fill_in "Name", :with => "Example User"
              fill_in "Email", :with => "user@example.com"
              fill_in "Password", :with => "foobar"
              fill_in "Confirmation", :with => "foobar"
              click_button
              response.should have_selector("div.flash.success",
                                            :content => "Bienvenue")
              response.should render_template('users/show')
            end.should change(User, :count).by(1)
          end
        end
end