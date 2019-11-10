class AddDetailsToTests < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:tests, :level, from: nil, to: 0)
    change_column_null(:tests, :title, false)
    add_reference :tests, :category, foreign_key: true
    add_reference :tests, :author, foreign_key: { to_table: :users }
  end
end
