class AddTrueToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :is_hidden, :boolean
  end
end
