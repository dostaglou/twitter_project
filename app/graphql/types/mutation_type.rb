module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignIn
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_tweet, mutation: Mutations::CreateTweet
    field :delete_my_tweet, mutation: Mutations::DeleteMyTweet
    field :create_follow, mutation: Mutations::CreateFollow
    field :unfollow, mutation: Mutations::Unfollow
    field :exterminate_user, mutation: Mutations::ExterminateUser
    field :add_like, mutation: Mutations::AddLike
    field :unlike, mutation: Mutations::Unlike
  end
end
