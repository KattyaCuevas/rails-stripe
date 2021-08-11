class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true unless record.private
    return false unless user

    AuthorizedArticle.where(user: user, article: record).exists?
  end
end
