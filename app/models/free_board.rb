class FreeBoard < ActiveRecord::Base
  belongs_to :category
  has_many :free_board_likes
  has_many :free_board_comments
  
  
  has_attached_file :image, :styles => {
                                       :mobile => '200x200#',
                                       :option => '100x100#',
                                       :main => '250x250#'
  },
                    :url  => "/free_board_images/:id_partition/:style.:extension",
                    :path => ":rails_root/public/free_board_images/:id_partition/:style.:extension",
                    :default_url => "free_board_images/missing/free_board_image_missing_:style.png"

  validates_attachment_size :image, :less_than => 1.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']
  
  def self_id_partition
    ("%09d" % self.id).scan(/\d{3}/).join("/")
  end
  
  
  
end