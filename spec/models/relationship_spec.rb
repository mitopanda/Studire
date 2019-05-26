require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @follow = FactoryBot.create(:user)
    @relationship = FactoryBot.create(:relationship, user_id: @user.id, follow_id: @follow.id)
  end

  context "relationshipが有効なとき" do
    it "有効なフォローの検証" do
     expect(@relationship).to be_valid
    end
  end

  context "relationshipが無効なとき" do

    it "ユーザーidが存在しない" do
      @relationship.user_id = ""
      expect(@relationship).to_not be_valid
    end

    it "フォローidが存在しない" do
      @relationship.follow_id = ""
      expect(@relationship).to_not be_valid
    end

    it "relationshipの重複" do
      relationship = FactoryBot.build(:relationship, user_id: @user_id, follow_id: @follow_id)
      expect(relationship).to_not be_valid
    end
  end
end