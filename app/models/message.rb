class Message < ApplicationRecord
  belongs_to :master
  belongs_to :team
  belongs_to :user
  belongs_to :channel

  def for_js
    {message: text, name: user_name, image_url: image, datetime: created_at.strftime(' %I:%M %p')}
  end
end
