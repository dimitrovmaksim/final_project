class ArticlesController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]
  skip_before_action :check_admin, only: [:index, :show]

  def index

    @page = params[:page].to_i
    @newer_page = @page - 1 unless @page == 0
    @older_page = @page + 1 unless (@page * 5 > Article.count)

    if params[:search]
      @articles = Article.search(params[:search]).limit(5).offset(@page * 5).order(created_at: :desc)
    elsif params[:month]
      date = Date.parse("1 #{params[:month]}")
      @articles = Article.limit(5).offset(@page * 5).where(:created_at => date..date.end_of_month)
    else
      @articles = Article.limit(5).offset(@page * 5).order(created_at: :desc)
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.includes(:user)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: 'Article created!'
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: 'Article updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, notice: 'Article deleted!'
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :image_url, :tag_list)
    end
end
