class Prototype < ApplicationRecord
  validates :title, :catch_copy, :concept, presence: true
end
