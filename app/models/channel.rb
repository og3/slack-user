class Channel < ApplicationRecord
  has_many :users, through: :channel_users
end
