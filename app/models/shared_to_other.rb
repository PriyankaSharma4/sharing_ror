class SharedToOther < ApplicationRecord
	belongs_to :location_share
	belongs_to :user, optional: true

end
