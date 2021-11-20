class AddUserIndexToWords < ActiveRecord::Migration[6.0]
  def change
    add_index :words, :user_id
  end
end
