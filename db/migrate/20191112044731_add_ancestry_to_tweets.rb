class AddAncestryToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :ancestry, :string
    add_index :tweets, :ancestry
  end
end
