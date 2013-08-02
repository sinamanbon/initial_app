class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      #creates by "magic" created_at and updated_at
      t.timestamps
    end
    #multiple key index which Active Record uses both keys
    add_index :microposts, [:user_id, :created_at]
  end
end
