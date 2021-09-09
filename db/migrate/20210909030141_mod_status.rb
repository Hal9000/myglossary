class ModStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default :words, :status, "unclaimed"
    Word.all.map {|x| x.status = "unclaimed" if x.status == "" || x.status == nil; x.save }
    change_column_null :words, :status, false
    # claimed completed draft in-progress unclaimed
  end
end
