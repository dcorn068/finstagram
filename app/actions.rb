# allow .html.erb extensions 
# https://stackoverflow.com/questions/11741585/how-do-i-use-html-erb-as-a-file-extension-for-my-views-with-sinatra
Tilt.register Tilt::ERBTemplate, 'html.erb'


#################
#### HELPERS ####
#################

helpers do
  def current_user
    return User.find_by(id: session[:user_id])
  end

  def do_login
    username = params[:username]
    password = params[:password]

    user = User.find_by(username: username)  

    if user && user.password == password
        session[:user_id] = user.id
        redirect to('/')
    else
        @error_message = "Login failed."
        erb(:login)
    end
  end

  def comments_form_partial(my_finstagram_post, allow_comments)
    return erb(:'shared/finstagram_post', { locals: { finstagram_post: my_finstagram_post, allow_new_comment: allow_comments }})
  end
end




#################
##### HOME ######
#################

get '/' do
    # TODO: filter posts if signed in
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end


#################
##### SIGNUP ####
#################

get '/signup' do     # if a user navigates to the path "/signup",
  @user = User.new   # setup empty @user object
  erb(:signup)       # render "app/views/signup.erb"
end

post '/signup' do
  my_email      = params[:email]
  my_avatar_url = params[:avatar_url]
  my_username   = params[:username]
  my_password   = params[:password]

  @user = User.new({ 
    email: my_email, 
    avatar_url: my_avatar_url, 
    username: my_username, 
    password: my_password 
    })

  if @user.save
    do_login
  else
    erb(:signup)
  end
end




#################
##### LOGIN #####
#################

get '/login' do
    erb(:login)
end

post '/login' do
    do_login
end



#################
##### LOGOUT ####
#################

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end





#################
#### NEW POST ###
#################

# show the "submit a post" form
get '/posts/new' do
    @new_post = FinstagramPost.new

    if current_user
        erb(:"posts/new")
    else
        redirect to('/login')
    end
end

# process a new finstagram post form submission
post '/posts' do
    my_photo_url = params[:photo_url]

    @new_post = FinstagramPost.new({ 
        photo_url: my_photo_url, 
        user_id: current_user.id, 
        })

    if @new_post.save
        redirect to('/')
    else
        erb(:"posts/new")
    end
end



##########################
#### VIEW SINGLE POST ####
##########################

get '/posts/:id' do
  @finstagram_post = FinstagramPost.find(params[:id])   # find the finstagram post with the ID from the URL
  erb(:"posts/show")               # render app/views/finstagram_posts/show.erb
end


#####################
#### NEW COMMENT ####
#####################

post '/comments' do
  # point values from params to variables
  my_comment_text = params[:text]
  finstagram_post_id = params[:finstagram_post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  comment = Comment.new({ text: my_comment_text, finstagram_post_id: finstagram_post_id, user_id: current_user.id })

  # save the comment
  comment.save

  # `redirect` back to wherever we came from
  redirect(back)
end
