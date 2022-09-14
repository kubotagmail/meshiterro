class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end


   # 投稿データの保存
   # if式を用いて、対象のカラム（ここではimageとshop_name）にデータが保存された場合はsaveメソッド(@post_image.save)がtrueになり、
   # 今まで通りredirect_toによりリダイレクト処理が走りバリデーションなどにより保存できなかった場合はsaveメソッドがfalseになり、
   # renderによりpost_images/new.html.erbが表示され投稿ページを再表示するように設定します。
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
    redirect_to post_images_path
    else
      render :new
    end

  end

  def index
    # 1ページ分の決められた数のデータだけを、新しい順に取得するように変更しています。
    # pageメソッドは、kaminariをインストールしたことで使用可能になったメソッドです。
    @post_images = PostImage.page(params[:page])
  end

  def show
    # @post_imageには特定のidのPostImageモデルを格納させます。
    @post_image = PostImage.find(params[:id])
    # コメントを投稿するためのインスタンス変数を定義します
    @post_comment = PostComment.new
  end

    def destroy
    # @post_image = 削除するPostImageレコードを取得
    @post_image = PostImage.find(params[:id])
    #  @post_image.削除
    @post_image.destroy
    # redirect_to PostImageの一覧ページへのパス
    redirect_to post_images_path
    end

   # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end
