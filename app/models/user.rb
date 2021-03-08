class User < ApplicationRecord
          
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :location_shares,  dependent: :destroy
    has_many :shared_to_others,  dependent: :destroy

end
