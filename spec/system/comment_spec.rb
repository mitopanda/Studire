require 'rails_helper'

include Warden::Test::Helpers

describe 'コメント投稿機能', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    sign_in @user
  end

  context '正常な情報を投稿したとき' do
    it 'コメントが表示される' do
      visit post_path(id: @post.id)
      fill_in 'comment', with: 'コメント'
      click_button '投稿'
      expect(page).to have_content 'コメント'
      expect(page).to have_css('div.alert.alert-info')
    end
  end

  context '無効な情報を投稿したとき' do
    it 'エラーが発生する' do
      visit post_path(id: @post.id)
      fill_in 'comment', with: ''
      click_button '投稿'
      expect(page).to have_css('div.alert.alert-danger')
    end
  end
end