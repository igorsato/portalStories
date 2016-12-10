class Gallery < ApplicationRecord
	belongs_to :attachable, :polymorphic => true
	has_attached_file :media,
		:styles => {
			thumb: '60x',
			small: '450x',
			large: '900x'
		}
  validates_attachment_size :media, :less_than => 20.megabytes
  validates_attachment_content_type :media, :content_type => ["image/jpeg", "image/jpg", "image/png", "image/gif"]
		
end
