require 'spec_helper'

describe "AuthPages" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it{ should have_selector('title',text:'Signin') }
    it { should have_selector('h1',text:'Signin')}
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do

      before { click_button 'Sign in'}
      
      it { should have_selector('title',text:'Signin') }
      it { should have_selector('div.alert.alert-error',text:'incorrect') }

      describe "flash msg should not appear on other pages" do
        before { visit signin_path }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user){ FactoryGirl.create(:user) }
      before do
        visit signin_path
        fill_in "Email", with:user.email.upcase
        fill_in "Password", with:user.password
        click_button "Sign in"
      end

      it { should have_link('Sign out',href:signout_path) }
      it { should_not have_link('Sign in',href:signin_path) }

      describe "after signout" do
        before { click_link "Sign out"}

        it { should_not have_link("Sign out",href:signout_path) }
      end
    end
  end

  describe "authorization" do
    let(:user){ FactoryGirl.create(:user) }
    describe "when users arent signed in" do

      describe "edit page" do
        before { visit edit_user_path(user) }
        it { should have_selector('title',text:'Signin')}
      end
      
      describe "update page" do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

    describe "when wrong user" do
      let(:wrong_user){ FactoryGirl.create(:user,email:'wrong@email.com')}

      describe "visits edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title',text:'Signin')}
      end

      describe "send update request" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end
end
