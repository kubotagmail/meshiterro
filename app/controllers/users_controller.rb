class UsersController < ApplicationController

  def show
    # 「XXX」となっている箇所には、「URLに記載されたIDを参考に、必要なUserモデルを取得する」処理を記述します。
# わからない場合は、sample_appやpost_imagesコントローラーで詳細画面を作成した時のカリキュラムを見返してみましょう。
  # @user = XXX
    @user = User.find(params[:id])
    # 1ページ分の決められた数のデータだけを、新しい順に取得するように変更しています。
    # pageメソッドは、kaminariをインストールしたことで使用可能になったメソッドです。
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    # ヒント：詳細ページで定義した時と同じく、URLを参考に特定のidを持ったレコードを取得する記述をしていきます。
    # @user = XXX
    @user = User.find(params[:id])
  end

  def update
    # この設定手順は、アプリケーションを完成させよう5章で行った流れと同様です。方法がわからないときは、改めて復習しておきましょう。
    # @user = ユーザーの取得
    @user = User.find(params[:id])
    # @user.ユーザーのアップデート
    @user.update(user_params)
    # redirect_to ユーザーの詳細ページへのパス
    redirect_to user_path(@user.id)
  end




  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
