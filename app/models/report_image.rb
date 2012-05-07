require 'open-uri'

class ReportImage < ActiveRecord::Base
  belongs_to :nude_report
  
  attr_accessor :image_url
  default_scope :order => 'position ASC'
  
  has_attached_file :image, :styles => {
                                       :mobile => '200x200#',
                                       :option => '150x150#',
                                       :main => '360x240#'
  },
                    :url  => "/report_images/:id_partition/:style.:extension",
                    :path => ":rails_root/public/report_images/:id_partition/:style.:extension",
                    :default_url => "report_images/missing/report_image_missing_:style.png"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 1.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']
  
  def self_id_partition
    ("%09d" % self.id).scan(/\d{3}/).join("/")
  end
  
  
end