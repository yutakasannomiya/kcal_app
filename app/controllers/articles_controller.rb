class ArticlesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :if_not_admin, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all.order("created_at DESC")
    @ranking_articles = Article.order("RAND()").limit(10)
  end

  def show
    
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      return redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @article.update(article_params)
      return redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      return redirect_to root_path
    else
      render 'show'
    end
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def article_params
    params.require(:article).permit(
      :title,
      :content,
      :about_time,
      :image
    ).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
