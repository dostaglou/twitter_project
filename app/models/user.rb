class User < ApplicationRecord
    has_secure_password

    has_many :tweets, dependent: :destroy
    has_many :likes, through: :tweets
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_many :passive_follow, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :passive_follow
  
    has_many :active_follow, foreign_key: :follower_id, class_name: 'Follow'
    has_many :following, through: :active_follow
  
    after_create :first_tweet

    def first_tweet
      Tweet.create( content: "I just joined Dwitter!", user_id: self.id )
    end

    def follow(user_id)
      if self.id != user_id && active_follow.find_by(following_id: user_id) == nil
        active_follow.create!(following_id: user_id)
      end
    end
  
    def unfollow(user_id)
      active_follow.find_by(following_id: user_id)&.destroy
    end

    def send_mail(username:, content:)
      puts "I am now staging an email"
      puts "It will go to me, #{self.username}}"
      puts "It will include the tweeter #{username} and the tweets content#{content}"
    end

end
