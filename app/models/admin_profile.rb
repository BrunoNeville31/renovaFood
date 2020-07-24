class AdminProfile < ApplicationRecord
    belongs_to :admin
    has_one_attached :avatar_admin
end
