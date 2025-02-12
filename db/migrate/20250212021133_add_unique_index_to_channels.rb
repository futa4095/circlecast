class AddUniqueIndexToChannels < ActiveRecord::Migration[7.2]
  def change
    add_index :channels, [:group_id, :title], unique: true
  end
end
