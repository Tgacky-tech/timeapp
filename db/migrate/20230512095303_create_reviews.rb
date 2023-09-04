class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :text
      t.datetime :day
      t.integer :user_id
  end
end
end
