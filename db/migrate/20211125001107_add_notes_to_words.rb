class AddNotesToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :notes, :text
  end
end
