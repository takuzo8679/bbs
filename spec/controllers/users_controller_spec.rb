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
end
