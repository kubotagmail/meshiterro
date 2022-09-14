class Favorite < ApplicationRecord

# Favoriteモデルのカラム（user_idとpost_image_id）は、UserモデルのidやPostImageモデルのidと関連付けが必要です。 
# この関連付けを、それぞれのモデルに設定します。
  belongs_to :user
  belongs_to :post_image
  
end
