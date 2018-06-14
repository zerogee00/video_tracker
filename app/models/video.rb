class Video < ApplicationRecord

  #----------------------------------------------------------------------------
  # Validations

  validates :name,               presence: true
  validates :brand,              presence: true
  validates :published_at,       presence: true

  #----------------------------------------------------------------------------
  # Associations

  has_many :views,                dependent: :destroy
  
  #----------------------------------------------------------------------------
  
end
