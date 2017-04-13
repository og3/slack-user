class Channel < ApplicationRecord
  validates :name, presence: true
  has_many :users, through: :channel_users
  # channelが消えると中間テーブルのレコードも消える。
  has_many :channel_users, dependent: :delete_all
  belongs_to :team
end
