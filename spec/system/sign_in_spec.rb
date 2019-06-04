require 'rails_helper'

include Warden::Test::Helpers

describe 'ログイン機能', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end

  context '有効な情報が送信されたとき' do
    it '記事一覧ページが表示される' do
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'ログイン'

      expect(page).to have_css('div.alert.alert-info')
    end
  end

  context '無効な情報が送信されたとき' do
    it 'ログインページにリダイレクトされる'do
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      click_button 'ログイン'
      
      expect(page).to have_css('div.alert.alert-danger')
    end
  end
end