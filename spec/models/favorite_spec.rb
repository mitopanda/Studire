require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @favorite = FactoryBot.create(:favorite, post: @post)
  end

  context "favoriteが有効であるとき" do

    it "有効なfavoriteの検証" do
      expect(@favorite).to be_valid
    end
  end

  context "favoriteが無効であるとき" do

    it "ユーザーidが存在しない" do
      @favorite.user_id = ""
      expect(@favorite).to_not be_valid
    end

    it "post_idが存在しない" do
      @favorite.post_id = ""
      expect(@favorite).to_not be_valid
    end

    it "ユーザーidとpost_idの重複" do
      favorite = FactoryBot.build(:favorite, post: @post)
      expect(favorite).to_not be_valid
    end
  end
end
