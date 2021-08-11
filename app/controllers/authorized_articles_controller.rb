class AuthorizedArticlesController < ApplicationController
  def create
    @authorized_article = AuthorizedArticle.new(
      article_id: params[:article_id],
      authorization_type: 'subscription',
      user: current_user
    )
    if @authorized_article.save
      flash[:success] = 'Artículo agregado a tu suscripción.'
      redirect_to article_path(id: params[:article_id])
    else
      flash[:error] = 'Algo falló, inténtalo de nuevo.'
      render 'articles#index'
    end
  end
end
