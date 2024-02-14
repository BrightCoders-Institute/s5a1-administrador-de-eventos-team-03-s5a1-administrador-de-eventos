class BrightEvent < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :cost, presence: true

  has_one_attached :image
  belongs_to :user

  validates :image, content_type: { in: %w[image/jpeg image/png image/jpg], message: 'Debe ser un archivo JPEG/PNG' }
end
