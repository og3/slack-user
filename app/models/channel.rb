class Channel < ApplicationRecord
  validates :name, presence: true
  has_many :users, through: :channel_users
  has_many :channel_users
  belongs_to :team
end
