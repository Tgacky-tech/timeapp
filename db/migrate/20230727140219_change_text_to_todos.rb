class ChangeTextToTodos < ActiveRecord::Migration[6.1]
  def change
    change_column :todos, :text, :text
  end
end
