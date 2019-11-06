users = ["a", "b", "Dillon", "Pat", "Orchid"]

users.each do |user|
    u = User.new(
      username: user,
      password: "123123",
      email: "#{user}@#{user}.com",
      bio: nil
      )
    u.save
    puts "#{u.username} account created"
    5.times do 
        t = Tweet.new(
            user_id: u.id,
            content: "I am some content",
        )
        t.save
    end
    puts "#{u.username} now has 5 tweets"
  end

