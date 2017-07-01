class Prototype < ApplicationRecord
  validates :title, :catch_copy, :concept, presence: true

  belongs_to :user

  has_many :captured_images
  accepts_nested_attributes_for :captured_images, allow_destroy: true, reject_if: :reject_posts

  def reject_posts(attributed)
    attributed['content'].blank?
  end

  def get_main_content
    captured_images.find_by(status: :main).content
  end
end
