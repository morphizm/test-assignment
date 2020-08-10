class AddSuccessfulToTestPassages < ActiveRecord::Migration[6.0]
  def change
    add_column :test_passages, :successful, :boolean, default: false
  end
end
