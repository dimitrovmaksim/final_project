class CommentsController < ApplicationController
  skip_before_action :check_admin, only: :create

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article)
      flash[:error] = 'Comment must be at least 3 characters long!'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
