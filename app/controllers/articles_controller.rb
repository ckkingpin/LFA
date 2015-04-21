class ArticlesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:category].blank?
      @articles = Article.includes(:categories).all.order("created_at DESC")
    else
      @category = Category.find_by(name: params[:category])
      @articles = @category.articles.order("created_at DESC")
    end
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.category_ids += article_params[:category_ids].split(',')
    if @article.save
      redirect_to @article, notice: 'Project was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      @article.category_ids += article_params[:category_ids].split(',')
      redirect_to @article, notice: 'Project was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, notice: 'Project was successfully deleted.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :category_ids)
  end
end
