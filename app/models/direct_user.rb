class DirectUser < ApplicationRecord
  belongs_to :direct
  belongs_to :user
end
