class FreeBoardComment < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :free_board
end