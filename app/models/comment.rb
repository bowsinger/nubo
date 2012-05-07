class Comment < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :nude_report
end
