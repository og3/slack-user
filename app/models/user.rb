class User < ApplicationRecord
    has_many :channels, through: :channel_users
    has_many :channel_users
    has_many :messages
    belongs_to :master
    belongs_to :team
end
