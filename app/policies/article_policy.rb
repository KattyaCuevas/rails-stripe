class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true unless record.private

    user.article_ids.include?(record.id)
  end
end
