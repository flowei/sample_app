require 'spec_helper'

describe PagesController do
  render_views
  
  before (:each) do
    @base_title = "Simple App du Tutoriel Ruby on Rails | "
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "titre Accueil" do
      get 'home'
      response.should have_selector("title", :content => @base_title+"Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "titre Contact" do
      get 'contact'
      response.should have_selector("title", :content => @base_title+"Contact")
    end
  end
  
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    
    it "titre About" do
      get 'about'
      response.should have_selector("title", :content => @base_title+"About")
    end
  end
  
  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
    
    it "titre Help" do
      get 'help'
      response.should have_selector("title", :content => @base_title+"Help")
    end
  end

end
