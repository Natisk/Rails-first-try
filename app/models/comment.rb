class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :user
  validates :user, :post_id, :user_id, :body, :presence => true
  validates :body, :length => { :maximum => 1024 }
end

