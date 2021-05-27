class CreateJoinTableOfferSkills < ActiveRecord::Migration[6.0]
  def change
    create_join_table :offers, :skills do |t|
      # t.index [:offer_id, :skill_id]
      # t.index [:skill_id, :offer_id]
    end
  end
end
