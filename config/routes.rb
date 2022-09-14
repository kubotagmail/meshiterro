Rails.application.routes.draw do
  
  devise_for :users
  root to: "homes#top"
  get "/homes/about" => "homes#about", as: "about"
  
  # コメントは、投稿画像に対してコメントされます。このため、post_commentsは、post_imagesに結びつきます。 以下のように親子関係になります。
  # post_image_post_comments POST   /post_images/:post_image_id/post_comments(.:format)     post_comments#create
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    
    # 単数形にすると、/:idがURLに含まれなくなります。
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    # $ rails routes
    # post_image_post_comments POST   /post_images/:post_image_id/post_comments(.:format)     post_comments#create
# 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成されるのが確認できます。
# このような親子関係を、「ネストする」と言います。上記のようなネストしたURLを作成することでparams[:post_image_id]でPostImageのidが取得できるようになります。
  end 
  
  resources :users, only: [:show, :edit, :update]
end