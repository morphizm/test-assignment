class AddDetailsToAnswers < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:answers, :correct, from: nil, to: false)
    add_reference :answers, :question, foreign_key: true
    add_column :answers, :title, :string
    change_column_null(:answers, :title, false)
  end
end
