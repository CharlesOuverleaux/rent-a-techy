class AddHourlyRateToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :hourly_rate, :integer, default: 0
  end
end
