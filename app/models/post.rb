class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validate :title, presence: true, length: { maximum: 250 }
  validate :comments_counter, numericality: { only_integer: true, greater_than_or_equal: 0 }
  validate :likes_counter, numericality: { only_integer: true, greater_than_or_equal: 0 }

  after_save :update_posts_counter
  def recent_comments
    comments.last(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
