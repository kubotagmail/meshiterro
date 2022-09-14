class PostImage < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  #shop_nameが存在しているかを確認するバリデーション
  validates :shop_name, presence: true
  #imageが存在しているかを確認するバリデーション  
  validates :image, presence: true



  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
  
  # favorited_by?メソッドを作成します。 このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
  # 存在していればtrue、存在していなければfalseを返すようにしています。
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
