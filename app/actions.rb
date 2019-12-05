get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/signup' do     # if a user navigates to the path "/signup",
  @user = User.new   # setup empty @user object
  erb(:signup)       # render "app/views/signup.erb"
end

post '/signup' do

  # grab user input values from params
  my_email      = params[:email]
  my_avatar_url = params[:avatar_url]
  my_username   = params[:username]
  my_password   = params[:password]

  # instantiate and save a User
  @user = User.new({ 
      email: my_email, 
      avatar_url: my_avatar_url, 
      username: my_username, 
      password: my_password 
    })

  # if all user params are present
 if @user.save
    "User #{username} saved!"
  else
    erb(:signup)
  end

end