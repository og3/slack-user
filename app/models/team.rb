class Team < ApplicationRecord
  has_many :masters, through: :master_teams
  has_many :master_teams
  has_many :users
end
