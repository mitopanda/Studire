require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before do
    @post = FactoryBot.create(:post)
  end
  
  context "postが有効であるとき" do
    it "全てのカラムが存在する" do
      expect(@post).to be_valid
    end
  end
  
  context "postが無効であるとき" do
    it "ユーザーに属していない" do
      @post.user_id = ""
      expect(@post).to_not be_valid
    end

    it "titleが存在しない" do
      @post.title = ""
      expect(@post).to_not be_valid
    end

    it "contentが存在しない" do
      @post.content = ""
      expect(@post).to_not be_valid
    end

    it "bookが存在しない" do
      @post.book = ""
      expect(@post).to_not be_valid
    end

    it "directionが存在しない" do
      @post.direction = ""
      expect(@post).to_not be_valid
    end

    it "summaryが存在しない" do
      @post.summary = ""
      expect(@post).to_not be_valid
    end

    it "titleが51文字以上である" do
      @post.title = "a"*51
      expect(@post).to_not be_valid
    end

    it "contentが2001文字以上" do
      @post.content = "a"*2001
      expect(@post).to_not be_valid
    end

    it "bookが2001字以上" do
      @post.book = "a"*2001
      expect(@post).to_not be_valid
    end

    it "directionが2001字以上" do
      @post.direction = "a"*2001
      expect(@post).to_not be_valid
    end

    it "summaryが2001字以上" do
      @post.summary = "a"*2001
      expect(@post).to_not be_valid
    end
  end

  
end
