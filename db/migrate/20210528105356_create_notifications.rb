class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :booking, foreign_key: true
      t.references :user, foreign_key: true
      t.string :msg
      t.boolean :showed, default: false
      t.timestamps
    end
  end
end
