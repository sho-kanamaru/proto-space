class CapturedImage < ApplicationRecord
  mount_uploader :content, ImageUploader
end
