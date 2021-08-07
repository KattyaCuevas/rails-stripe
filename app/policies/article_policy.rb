class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user || !record.private
  end
end
