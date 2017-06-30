class CapturedImage < ApplicationRecord
  mount_uploader :content, ImageUploader

  enum status: { main: 0, sub: 1 }
end
