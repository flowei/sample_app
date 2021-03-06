require 'spec_helper'



describe UsersController do
  
  render_views
  
  describe "GET 'show'" do
    
    before (:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should success" do
      get :show, :id => @user
      response.should be_succes
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    
    it "should include user name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
    
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    it "devrait avoir un champ name" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end

    it "devrait avoir un champ email" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end

    it "devrait avoir un champ mot de passe" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end

    it "devrait avoir un champ confirmation du mot de passe" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end

  it "titre Sign In" do
      get 'new'
      response.should have_selector("title", :content => "Sign Up")
  end
  
  describe "POST 'create'" do

      describe "échec" do

        before(:each) do
          @attr = { :name => "", 
                    :email => "", 
                    :password => "",
                    :password_confirmation => "" }
        end

        it "ne devrait pas créer d'utilisateur" do
          lambda do
            post :create, :user => @attr
          end.should_not change(User, :count)
        end

        it "devrait avoir le bon titre" do
          post :create, :user => @attr
          response.should have_selector("title", :content => "Sign Up")
        end

        it "devrait rendre la page 'new'" do
          post :create, :user => @attr
          response.should render_template('new')
        end
      end
      
      describe "succès" do

            before(:each) do
              @attr = { :name => "New User", 
                        :email => "user@example.com",
                        :password => "foobar", 
                        :password_confirmation => "foobar" }
            end

            it "devrait créer un utilisateur" do
              lambda do
                post :create, :user => @attr
              end.should change(User, :count).by(1)
            end

            it "devrait rediriger vers la page d'affichage de l'utilisateur" do
              post :create, :user => @attr
              response.should redirect_to(user_path(assigns(:user)))
            end
            
            it "devrait avoir un message de bienvenue" do
              post :create, :user => @attr
              flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
            end  
            
            it "should identify user" do
              post :create, :user => @attr
              controller.should be_signed_in
            end
            
          end
    end
end
