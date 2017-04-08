class User < ApplicationRecord
    has_many :channels, through: :channel_users
    belongs_to :master
    belongs_to :team
end
