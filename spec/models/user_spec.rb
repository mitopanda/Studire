require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  context "ユーザーが有効であるとき" do
    it "name,email,password,password_confirmationが存在する" do
      expect(@user).to be_valid
    end
  end
  
  context "ユーザーが無効であるとき" do
    it "nameが存在しない" do
      @user.name = ""
      expect(@user).to_not be_valid
    end

    it "nameが51文字以上である" do
      @user.name = "a"*51
      expect(@user).to_not be_valid
    end

    it "emailが存在しない" do
      @user.email = ""
      expect(@user).to_not be_valid
    end

    it "emailの重複" do
      FactoryBot.create(:user, email: "user@test.com")
      user = FactoryBot.build(:user, email: "user@test.com")
      expect(user).to_not be_valid
    end
    
    it "passwordが存在しない" do
      @user.password = ""
      @user.password_confirmation = ""
      expect(@user).to_not be_valid
    end

    it "passwordが６文字未満である" do
      @user.password = "passw"
      @user.password_confirmation = "passw"
      expect(@user).to_not be_valid
    end

    it "passwordとconfirmationが異なる" do
      @user.password_confirmation = "posswerd"
      expect(@user).to_not be_valid
    end

    it "profileが200文字を越える" do
      @user.profile = "a"*201
      expect(@user).to_not be_valid
    end
  end
end
