class FinstagramPost < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  has_many :likes

  validates :photo_url, :user, presence: true

  def humanized_time_ago
    return 0

    # time_ago_in_seconds = Time.now - self.created_at
    # time_ago_in_minutes = time_ago_in_seconds / 60

    # if time_ago_in_minutes >= 60
    #   "#{(time_ago_in_minutes / 60).to_i} hours ago"
    # else
    #   "#{time_ago_in_minutes.to_i} minutes ago"
    # end
  end
  # New Stuff Start 
  def like_count
    return 0
    # self.likes.size
  end

  def comment_count
    return 0
    # self.comments.size
  end
  # New Stuff End
end