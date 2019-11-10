class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :picture_file, default: 'badge.jpg'
      t.string :rule_name
      t.string :rule_parameter

      t.timestamps
    end
  end
end
