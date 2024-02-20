class BrightEvent < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :cost, presence: true

  has_one_attached :image
  belongs_to :user

  validates :image, content_type: { in: %w[image/jpeg image/png image/jpg], message: 'Debe ser un archivo JPEG/PNG' }

  scope :all_events, -> (user) { where('privacy = ? OR user_id = ?', false, user.id) }
  scope :filter_date, -> (from, to) { where(date: from.to_date.beginning_of_day..to.to_date.end_of_day) }
  paginates_per 5
end
