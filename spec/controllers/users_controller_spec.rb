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
    before do
      # refereは現在のページの前にどこにいたかを示す情報。これがないとエラーになるので設定しておく
        # @を付けてインスタンス変数とすることでブロックを超えて参照できる
          # 実装がredirect_backではなくredirectでページ指定しているので今回はコメントアウト
      # @referer = 'http://localhost'
      # @request.env['HTTP_REFERER'] = @referer
    end
    context '正しいユーザー情報が渡って来た場合' do
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
      it 'マイページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end
    context 'パラメータに正しいユーザー名、確認パスワードが含まれていない場合' do
      before do
        post(:create, params: {
          user: {
            name: 'ユーザー1',
            password: 'password',
            password_confirmation: 'invalid_password'
          }
        })
      end
      # リファラーにリダイレクトされないので省略
      # it 'リファラーにリダイレクトされること' do
      #   expect(response).to redirect_to(@referer)
      # end
      it 'リダイレクトされること' do
        expect(response).to redirect_to('http://test.host/users/new')
      end
      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end
      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード(確認)とパスワードの入力が一致しません'
      end
    end
  end
end
