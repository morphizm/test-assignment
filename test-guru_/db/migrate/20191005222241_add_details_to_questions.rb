class AddDetailsToQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:questions, :title, false)
    add_reference :questions, :test, foreign_key: true
  end
end
