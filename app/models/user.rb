class User < ApplicationRecord
    belongs_to :master
    belongs_to :team
end
