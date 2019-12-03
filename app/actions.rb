get '/' do

#   finstagram_post_whale = {
#     photo_url: "http://naserca.com/images/whale.jpg",
#   }

#   my_new_post = FinstagramPost.new(finstagram_post_whale)
  
#   my_whale_user = {
#       username: "hellooo",
#       avatar_url: "https://picsum.photos/64/64",
#       email: "hellooo@hi.com",
#       password: "password1",
#     }
    
#     my_new_user = User.new(my_whale_user)
#     my_new_post.user_id = my_new_user.id

#     my_new_post.save
#     my_new_user.save

# user_kirk = User.new({ username: "kirk_whalum", avatar_url: "http://naserca.com/images/kirk_whalum.jpg" })
# user_kirk.save

# finstagram_post_kirk = FinstagramPost.new({ photo_url: "http://naserca.com/images/whale.jpg", user_id: user_kirk.id })
# finstagram_post_kirk.save

  
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
#   @finstagram_posts = FinstagramPost.all
  erb(:index)
end