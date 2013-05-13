require 'spec_helper'

describe "Users" do

  subject { page }

  describe "signup page" do

    before { visit signup_path }

    it { should have_selector('title',text:'Signup')}
    it { should have_selector('h1',text:'Signup')}
  end

  describe "signup page" do
    let(:user){ FactoryGirl.create(:user) }
    
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_selector('title',text:user.name) }
  end

  describe "signup form" do
    before { visit signup_path }

    describe "when submitted empty" do
      it "should not create user" do
        expect { click_button "Create account"}.not_to change(User,:count)
      end
    end

    describe "when submitted with valid info" do
      before do
        fill_in "Name",         with:"Username"
        fill_in "Email",        with:"email@mail.com" 
        fill_in "Password",     with:"password"
        fill_in "Password confirmation",        with:"password"
      end
      it "should create a new user" do
        expect{ click_button "Create account" }.to change(User,:count)
      end
    end
  end

  describe "edit" do
    let(:user){ FactoryGirl.create(:user) }
    before  do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('title',text:'Edit profile') }
    end

    describe "when submitted with invalid info" do
      before { click_button 'Update profile' }
      it { should have_css('div.alert.alert-error') }
    end

    describe "when submitted with valid info" do
      before do
        fill_in "Name", with:"New Name"
        fill_in "Email", with:"new@email.com"
        fill_in "Password", with:user.password
        fill_in "Password confirmation", with:user.password
        click_button "Update profile"
      end

      it { should_not have_css('div.alert.alert-error')}
      it { should have_css('div.alert.alert-success')}
      it { should have_link('Edit',href:edit_user_path(user)) }
      specify { user.reload.name.should=="New Name" }
      specify { user.reload.email.should=="new@email.com" }
    end

  end
end
