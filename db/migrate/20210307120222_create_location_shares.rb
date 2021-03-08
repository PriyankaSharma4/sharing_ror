class CreateLocationShares < ActiveRecord::Migration[6.1]
  def change
    create_table :location_shares do |t|

    	t.references :user, foreign_key: true
    	t.string :address, :default => ""
    	t.decimal :lat, :precision => 15, :scale => 10
    	t.decimal :long, :precision => 15, :scale => 10
    	t.boolean :is_public , default: false

      	t.timestamps
    end
  end
end
