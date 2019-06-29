require 'rails_helper'

include Warden::Test::Helpers

describe 'サインアップ機能', type: :system, js: true do
  context '有効な情報を送信したとき' do
    it 'トップページにリダイレクトされる' do
      visit new_user_registration_path
      fill_in 'name', with: 'Test'
      fill_in 'email', with: 'test@user.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button '会員登録'
      expect(page).to have_css('div.alert.alert-info')
    end
  end

  context '無効な情報を送信したとき' do
    it 'エラーが起こる' do
      visit new_user_registration_path
      fill_in 'name', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password_confirmation', with: ''
      click_button '会員登録'
      expect(page).to have_css('div#error_explanation')
      expect(page).to have_content 'メールアドレスを入力してください'
    end
  end
end
