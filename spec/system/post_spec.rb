require 'rails_helper'

include Warden::Test::Helpers

describe 'ポスト機能', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    visit root_path
    sign_in @user
  end
  describe '投稿機能' do
    before do
      visit new_post_path
    end
    context '有効な情報を送信したとき' do
      it '正常に登録される' do
        expect do
          fill_in 'post-count', with: 'タイトルです。'
          fill_in '学習内容', with: '学習内容です。'
          fill_in '教材', with: '教材です。'
          fill_in '学習方法', with: '学習方法です。'
          fill_in 'まとめ', with: 'まとめです。'
          click_button '投稿'

          expect(page).to have_content '学習内容です。'
          expect(page).to have_content '投稿に成功しました'
        end.to change(@user.posts, :count).by(1)
      end
    end

    context '無効な情報を送信したとき' do
      it 'エラーとなる' do
        expect do
          fill_in 'post-count', with: ''
          fill_in '学習内容', with: ''
          fill_in '教材', with: ''
          fill_in '学習方法', with: ''
          fill_in 'まとめ', with: ''
          click_button '投稿'

          expect(page).to have_content '投稿に失敗しました'
        end.to change(@user.posts, :count).by(0)
      end
    end
  end

  describe '投稿の編集機能' do
    before do
      @post = FactoryBot.create(:post, user: @user)
      visit edit_post_path(id: @post.id)
    end
    context '有効な情報を送信したとき' do
      it '正常に更新される' do
        expect do
          fill_in 'タイトル', with: 'タイトルです。'
          fill_in '学習内容', with: '学習内容です。'
          fill_in '教材', with: '教材です。'
          fill_in '学習方法', with: '学習方法です。'
          fill_in 'まとめ', with: 'まとめです。'
          click_button '投稿'

          expect(page).to have_content '投稿の編集に成功しました'
        end
      end
    end

    context '無効な情報を送信したとき' do
      it '編集に失敗する' do
        expect do
          fill_in 'タイトル', with: ''
          fill_in '学習内容', with: ''
          fill_in '教材', with: ''
          fill_in '学習方法', with: ''
          fill_in 'まとめ', with: ''
          click_button '投稿'

          expect(page).to have_content '投稿の編集に失敗しました'
        end
      end
    end
  end

  describe '投稿削除機能' do
    before do
      @post = FactoryBot.create(:post, user: @user)
      visit post_path(id: @post.id)
    end

    it '正常に削除される' do
      expect do
        click_link '削除'
        page.accept_confirm 'You sure?'
        expect(page).to have_content '投稿を削除しました'
      end.to change(@user.posts, :count).by(-1)
    end
  end

  describe '投稿詳細機能' do
    before do
      @other_user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, user: @user)
      @other_post = FactoryBot.create(:post, user: @other_user)
    end

    context '現在のユーザーの投稿の場合' do
      it '編集&削除リンクが表示' do
        visit post_path(id: @post.id)
        expect(page).to have_link '編集'
        expect(page).to have_selector 'a[data-method=delete]'
      end
    end

    context '他のユーザーの投稿の場合' do
      it '編集&削除リンクが表示されない' do
        visit post_path(id: @other_post.id)
        expect(page).not_to have_link '編集'
        expect(page).not_to have_selector 'a[data-method=delete]'
      end
    end
  end
end
