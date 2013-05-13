require 'spec_helper'

describe "Users" do
  before { @user=User.new(name:'Test User',
                          email:'test@email.com',
                          password:'password',
                          password_confirmation:'password')}

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "remember token" do
    before{ @user.save }
    its(:remember_token){ should_not be_blank }
  end

  describe "when name is not present" do
    before { @user.name='' }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email='' }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name='a'*51 }
    it { should_not be_valid }
  end

  describe "when email is invalid" do
    it "should be invalid" do
      emails=%w[user@foo @email.com dd.com user@foo**.com]
      emails.each do |e|
        @user.email=e
        @user.should_not be_valid
      end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      emails=%w[email@email.com valid@email.com user@goatmail.com]
      emails.each do |e|
        @user.email=e
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    it "should not be valid" do
      duplicate_user=@user.dup
      duplicate_user.save
    end
    it { should be_valid }
  end

  describe "when taken email is entered in all caps" do
    it "should be valid" do
      duplicate_user_with_all_caps=@user.dup
      duplicate_user_with_all_caps.email=@user.email.upcase
      duplicate_user_with_all_caps.save
    end

    it{ should be_valid }
  end

  describe "when password is not present" do
    before { @user.password=@user.password_confirmation='' }
    it { should_not be_valid }
  end

  describe "when password and password_confirmation donot match" do
    before{ @user.password='some_other_value' }
    it { should_not be_valid }
  end

  describe "when password is short" do
    before { @user.password='4'*5 }    
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before{ @user.save }
    let(:found_user){ User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:invalid_user){ found_user.authenticate("invalid") }
      it { should_not == invalid_user}
    end
  end
end
