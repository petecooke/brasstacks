class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|

    	t.integer  :race_id

    	t.integer  :program_num
    	t.string   :name
    	t.integer  :age
    	t.string   :meds
    	t.string   :equip
    	t.float    :odds
    	t.string   :official_finish
    	t.integer  :speed_rating
    	t.string   :jockey_first_name
    	t.string   :jockey_last_name
    	t.string   :trainer_first_name
    	t.string   :trainer_last_name
    	t.string   :owner
    	t.string   :comment
    	t.float    :win_payoff
    	t.float    :place_payoff
    	t.float    :show_payoff
    	t.float    :show_payoff2

        t.timestamps
    end
  end
end

