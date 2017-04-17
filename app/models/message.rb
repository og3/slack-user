class Message < ApplicationRecord
  belongs_to :master
  belongs_to :team
  belongs_to :user
  belongs_to :channel
end
