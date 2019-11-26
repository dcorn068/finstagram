get '/' do
    @example_string = "cool dawg"
    erb(:index) # look in app/views for a file called "index.erb"
end