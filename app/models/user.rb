class User < ApplicationRecord
    has_many :channels, through: :channel_users
    has_many :channel_users
    has_many :directs, through: :direct_users
    has_many :direct_users
    has_many :messages
    belongs_to :master
    belongs_to :team
end
