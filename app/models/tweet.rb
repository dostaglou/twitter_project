class Tweet < ApplicationRecord
  belongs_to :user
  after_create :notify_user

  validates :content, length: {minimum: 1, maximum: 140}
  validates :user_id, presence: true

  # "I am a big fan of Daisuke"

  def notify_user
    arr = []
    reg = /(@\w+)/
    users = self.content.scan(reg)
    users.flatten.each do |el| 
      el.gsub!(/@/, '')
      sql = <<-SQL
      select * from users
      where username is "#{el}"
      SQL
      arr << ActiveRecord::Base.connection.execute(sql)
    end
    # arr.flatten.each do |user|
    #   user.send_mail(self.user.username, self.content)
    # end
    nil
  end
end
