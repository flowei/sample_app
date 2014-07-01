require 'spec_helper'

describe "LayoutLinks" do
  it "devrait trouver une page Accueil a '/'" do
    get '/'
  response.should have_selector('title', :content => "Home")
  end
  it "devrait trouver une page Contact at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  it "devrait trouver une page Help a '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  it "devrait trouver une page Sign Up a '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign Up")
  end
  
  describe "when not identified" do
    it "should have connection link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end
  
  describe "when identified" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end
    
    it "should have a deconnection link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end
    
    it "should have profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profil")
    end
  end
end
