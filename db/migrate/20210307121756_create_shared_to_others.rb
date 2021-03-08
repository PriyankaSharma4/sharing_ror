class CreateSharedToOthers < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_to_others do |t|

    	t.references :location_share, foreign_key: true
    	t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
