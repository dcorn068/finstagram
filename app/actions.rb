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

get '/new_post' do
    @new_post = FinstagramPost.new

    if current_user
        erb(:new_post)
    else
        redirect to('/login')
    end
end

post '/new_post' do
    my_user_id = current_user.id
    my_photo_url = params[:photo_url]

    @new_post = FinstagramPost.new({ 
        photo_url: my_photo_url, 
        user_id: my_user_id, 
        })

    if @new_post.save
        redirect to('/')
    else
        erb(:new_post)
    end
end