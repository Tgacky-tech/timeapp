class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :password_digest
      t.text :email
      t.text :name
  end
  end
end
