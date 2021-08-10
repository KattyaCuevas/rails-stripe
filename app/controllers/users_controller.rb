class UsersController < ApplicationController
  def profile
    @articles = Article.where(id: current_user.article_ids)
  end
end
