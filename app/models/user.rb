class User < ActiveRecord::Base

  has_many :finstagram_post
  has_many :comment
  has_many :like

end