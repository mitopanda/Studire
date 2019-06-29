require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.create(:comment)
  end

  context 'コメントが有効であるとき' do
    it '全てのカラムが存在する' do
      expect(@comment).to be_valid
    end
  end

  context 'コメントが無効であるとき' do
    it 'contentが存在しない' do
      @comment.content = ''
      expect(@comment).to_not be_valid
    end

    it 'contentが201文字以上である' do
      @comment.content = 'a' * 201
      expect(@comment).to_not be_valid
    end

    it 'userに属していない' do
      @comment.user_id = ''
      expect(@comment).to_not be_valid
    end

    it 'postに属していない' do
      @comment.post_id = ''
      expect(@comment).to_not be_valid
    end
  end
end
