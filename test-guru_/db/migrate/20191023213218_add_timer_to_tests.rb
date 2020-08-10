class AddTimerToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :timer, :time
  end
end
