require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end
  
  describe "POST 'create'" do
    
    describe "invalid signin" do
      
      before(:each) do 
        @attr = { :email => "email@example.com",
                  :password => "invalid" }
      end
      
      it "should re-render page new" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it "should have right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end
      
      it "should have flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~/invalid/i
      end
    end
    
    describe "valid signin"
      
    before(:each) do
      @user = FactoryGirl.create(:user)
      @attr = { :email => @user.email, :password => @user.password}
    end
    
    it "should authenticate user" do
      post :create, :session => @attr
      controller.current_user.should == @user
      controller.should be_signed_in
    end
    
    it "should redirect to user show page" do
      post :create, :session => @attr
      response.should redirect_to(user_path(@user))
    end
  end
  
  describe "DELETE 'destroy'" do
    
    it "should disconnect user" do
      test_sign_in(FactoryGirl.create(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
    
    
  end
end
