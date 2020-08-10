class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    #change_column_null(:users, :name, false)
    add_column :users, :email, :string
  end
end
