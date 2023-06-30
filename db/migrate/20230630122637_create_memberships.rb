class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :admin, default: false, null: false
      t.boolean :withdrawal, default: false, null: false

      t.timestamps
    end
    add_index :memberships, [:group_id, :user_id], unique: true
  end
end
