require 'rails_helper'

# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    # このコントローラのnewにGETでアクセスして結果がresponseに格納される
    before { get :new }
    it 'レスポンスコードが200であること' do
      # 結果をmatcherで確認
      expect(response).to have_http_status(:ok)
    end
    it 'newテンプレートをレンダリングすること' do
      # このmatherはgemをインストールしたことにより使用可能
      expect(response).to render_template :new
    end
    it '新しいuserオブジェクトがビューに渡されること' do
      # viewに渡されるべき変数のテスト
        # assignsメソッドの引数は変数名のシンボル
        # Userクラスの新しい変数がセットされていること
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    context '正しいユーザー情報が渡ってきた場合' do
      let(:params) do
        { user: {
          name: 'user',
          password: 'password',
          password_confirmation: 'password',
          }
        }
      end
      it 'ユーザーが一人増えていること' do
        # change matcherは実行の前後の変化を確認できる
          # ブロックで渡す。この場合はcountが1増えていること
        expect { post :create, params: params }.to change(User, :count).by(1)
      end
      it 'マイページにリダイレクトされていること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end
  end
end
