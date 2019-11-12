class AddPopularityToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :popularity, :integer, default: 0
  end
end
