class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :category_id
      t.text :name
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :user_id
  end
  end
end
