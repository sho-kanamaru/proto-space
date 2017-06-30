class Prototype < ApplicationRecord
  validates :title, :catch_copy, :concept, presence: true

  has_many :captured_images
  accepts_nested_attributes_for :captured_images, allow_destroy: true
end
