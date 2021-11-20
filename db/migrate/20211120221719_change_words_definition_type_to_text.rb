class ChangeWordsDefinitionTypeToText < ActiveRecord::Migration[6.0]
  def change
    change_column :words, :definition, :text
  end
end
