class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
    t.integer :category_id
    t.text :name
    t.datetime :register_time
    t.integer :user_id
  end
end
end
