class ChecksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def check
    # find_or_create_byとは、「レコードがなければ作り、あればレコード情報を返す」というメソッド
    Check.find_or_create_by(user_id: current_user.id, article_id: @article.id)
    # 既読のレコードを作成したら詳細ページを表示
    redirect_to controller: :articles, action: :show
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
