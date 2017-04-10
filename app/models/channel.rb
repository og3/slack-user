class Channel < ApplicationRecord
  has_many :users, through: :channel_users
  has_many :channel_users
end
