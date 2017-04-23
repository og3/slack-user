class Direct < ApplicationRecord
  has_many :users, through: :direct_users
  # directが消えると中間テーブルのレコードも消える。
  has_many :direct_users, dependent: :delete_all
  has_many :messages
  belongs_to :team
end
