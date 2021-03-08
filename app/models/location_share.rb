class LocationShare < ApplicationRecord
	belongs_to :user
	has_many :shared_to_others,  dependent: :destroy
end
