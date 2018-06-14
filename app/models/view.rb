class View < ApplicationRecord

  #----------------------------------------------------------------------------
  # Validations

  validates :video_id,      presence: true
  validates :viewed_at,     presence: true

  #----------------------------------------------------------------------------
  # Associations

  belongs_to :video
  
  #----------------------------------------------------------------------------
  
end
