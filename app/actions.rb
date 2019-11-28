get '/' do

    # let's create a new dog
    myDogSpot = Dog.new()

    return myDogSpot.poop
end