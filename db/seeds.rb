users = ["a", "b", "Dillon", "Pat", "orchid", "yoshi", "jordan", "sato", "francois", "ten"]

users.each do |user|
    u = User.new(
      username: user,
      password: "123123",
      email: "#{user}@#{user}.com",
      bio: nil
      )
    u.save
    puts "#{u.username} account created"
    (rand*10).round.times do 
        t = Tweet.new(
            user_id: u.id,
            content: "I am some content",
            created_at: (rand*7).days.ago
        )
        t.save
    end
    puts "#{u.username} now has some tweets"
  end

def follow_time
  puts "now we follow each other"
  active = User.first(5)
  passive = User.last(5)
  passive.each do |pas|
    active.each { |el| el.follow(pas.id)}
  end
end

follow_time

users2 = ["c", "d", "e", "f", "g", "h", "i"]

users2.each do |user|
  u = User.new(
    username: user,
    password: "123123",
    email: "#{user}@#{user}.com",
    bio: nil
    )
  u.save
  puts "#{u.username} account created"
  (rand*5).round.times do 
      t = Tweet.new(
          user_id: u.id,
          content: "I am some content",
          created_at: (rand*7).days.ago
      )
      t.save
  end
  puts "#{u.username} now has 5 tweets"
end