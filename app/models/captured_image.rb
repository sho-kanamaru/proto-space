class CapturedImage < ApplicationRecord
  mount_uploader :content, ContentUploader

  enum status: [:main, :sub]

  belongs_to :prototype, optional: true
end
