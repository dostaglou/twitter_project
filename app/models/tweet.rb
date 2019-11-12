class Tweet < ApplicationRecord
  belongs_to :user
  # has_ancestors
  
  has_many :likes
  
  after_create :notify_user
  
  validates :content, length: {minimum: 1, maximum: 140}
  validates :user_id, presence: true

  def notify_user
    arr = []
    reg = /(@\w+)/
    users = self.content.scan(reg)
    users.flatten.each do |el| 
      el.gsub!(/@/, '')
      arr << User.find_by_username(el)
    end
    arr&.each do |user|
      user&.send_mail({username: self.user.username, content: self.content})
    end
  end
end
