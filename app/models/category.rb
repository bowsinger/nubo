class Category < ActiveRecord::Base
  has_many :free_boards
  has_many :nude_reports
end
