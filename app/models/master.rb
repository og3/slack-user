class Master < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
:recoverable, :confirmable, :rememberable, :trackable, :validatable, :confirmable
end
