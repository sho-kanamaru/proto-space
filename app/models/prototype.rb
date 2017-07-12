class Prototype < ApplicationRecord
  validates :title, :catch_copy, :concept, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :captured_images, dependent: :destroy
  accepts_nested_attributes_for :captured_images, allow_destroy: true, reject_if: :reject_posts

  def reject_posts(attributed)
    attributed['content'].blank?
  end

  def get_main_content
    captured_images.main.first.content
  end

  def get_sub_contents
    captured_images.sub
  end

  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end
end
