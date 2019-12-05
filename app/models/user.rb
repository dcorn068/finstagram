class User < ActiveRecord::Base

  has_many :finstagram_post
  has_many :comment
  has_many :like

  validates :email, :username, uniqueness: true
  validates :email, :avatar_url, :username, :password, presence: true

end