class Article < ApplicationRecord
  before_save :add_body_preview, if: :body?

  scope :free, -> { where(private: false) }
  scope :paid, -> { where(private: true) }

  def add_body_preview
    self.body_preview = body[0..150]
  end

  def tag
    { class: tag_class, name: tag_name }
  end

  private

  def tag_name
    private ? 'Locked' : 'Free'
  end

  def tag_class
    return 'bg-red-200 text-red-600' unless private

    'bg-blue-200 text-blue-600'
  end
end
