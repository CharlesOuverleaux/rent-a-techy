class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :hue_code # hsl color code
      t.timestamps
    end
  end
end
