class User < ApplicationRecord
    has_secure_password
    has_many :tweets, dependent: :destroy
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true

    has_many :passive_follow, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :passive_follow
  
    has_many :active_follow, foreign_key: :follower_id, class_name: 'Follow'
    has_many :following, through: :active_follow, source: :tweets
  
    after_create :first_tweet

    # has_many :feed_tweets, through: :active_follow, source: :following_id

    def first_tweet
      Tweet.create( content: "I just joined Dwitter!", user_id: self.id )
      first_follow
    end

    def first_follow
      self.follow(self.id)
    end

    def follow(user_id)
      active_follow.create(following_id: user_id)
    end
  
    def unfollow(user_id)
      active_follow.find_by(following_id: user_id)&.destroy
    end

end
