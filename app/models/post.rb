# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  data        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  status      :boolean          default(FALSE)
#  explanation :text
#

class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title, :tags_attributes, :status, :explanation, :user_id
  validates :title, :body, :presence => true  
  has_many :blog_comments, :dependent => :destroy
  scope :nothidden,             -> { where("title  NOT LIKE '%hidden%' ") }
  scope :unapproved,            -> { where(:status => false) }
  #scope :unapproved_post_lim,   -> { unapproved.where("posts_count < 3") }
  belongs_to :user
  has_many :post_tags
  has_many :tags, :through=>:post_tags
  accepts_nested_attributes_for :tags
  attr_accessor :tags_attributes
  before_save :check_tag


    def check_tag
      self.tags.delete_all
      self.tags = tags_attributes.map do |_, tag|
        tag = Tag.find_or_create_by_tag_word(tag[:tag_word])
        tag unless tag.new_record?
      end.compact
    end



end
