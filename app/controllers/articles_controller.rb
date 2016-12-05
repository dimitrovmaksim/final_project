class ArticlesController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]
  skip_before_action :check_admin, only: [:index, :show]


  def index
    per_page = 5
    page = params[:page].present? ? params[:page].to_i : 1
    page_offset = (page - 1) * per_page

    articles_query = nil

    if params[:search]
      articles_query = Article.search(params[:search]).order(created_at: :desc)
    elsif params[:month]
      date = Date.parse("1 #{params[:month]}")
      articles_query = Article.where(:created_at => date..date.end_of_month).order(created_at: :desc)
    else
      articles_query = Article.order(created_at: :desc)
    end

    all_count = articles_query.count

    @articles = articles_query.limit(per_page).offset(page_offset)
    @newer_page = page - 1 unless page == 1
    @older_page = page + 1 unless page_offset + per_page >= all_count

    @additional_options = {}
    @additional_options[:month] = params[:month] if params[:month].present?
    @additional_options[:search] = params[:search] if params[:search].present?
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
