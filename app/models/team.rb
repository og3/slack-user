class Team < ApplicationRecord
  has_many :masters, through: :master_teams
  has_many :master_teams
  has_many :users
  has_many :channels
  has_many :messages
end
