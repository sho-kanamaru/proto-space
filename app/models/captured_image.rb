class CapturedImage < ApplicationRecord
  mount_uploader :content, ContentUploader

  enum status: %w(main sub)

  belongs_to :prototype, optional: true
end
