class AddAvailableNowColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :available_now, :boolean, default: false
  end
end
