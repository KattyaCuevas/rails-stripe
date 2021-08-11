class Article < ApplicationRecord
  # Callbacks
  before_save :add_body_preview, if: :body?

  # Associations
  belongs_to :category, optional: true

  # Scopes
  scope :free, -> { where(private: false) }
  scope :paid, -> { where(private: true) }

  delegate :price, to: :category

  def add_body_preview
    self.body_preview = body[0..150]
  end

  def tag
    { class: tag_class, name: tag_name }
  end

  private

  def tag_name
    return 'Free' unless private

    category.name
  end

  def tag_class
    return 'bg-red-200 text-red-600' unless private
    return 'bg-blue-200 text-blue-600' if category.name == 'Basic'
    return 'bg-purple-200 text-purple-700' if category.name == 'Premium'
  end
end
