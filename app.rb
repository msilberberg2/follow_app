require 'sinatra'
require 'sinatra/activerecord'
require './models/user'      
require './models/follow'
require 'sinatra/flash'

##These are test users and a test relationship that are in the initial table. Get rid of them in the final implementation.
User.delete_all
Follow.delete_all

user = User.new(handle: "Paul")
user.save

user = User.new(handle: "Carl")
user.save
		
user = User.new(handle: "Test0 Follower")
user.save
		
user = User.new(handle: "Test1 Follower")
user.save
		
user = User.new(handle: "Test2 Follower")
user.save
		
user = User.new(handle: "Test3 Follower")
user.save

#Paul follows Carl
user1 = User.where(handle: "Paul").first
user2 = User.where(handle: "Carl").first
relation = Follow.new(follower_id: user1.id, followee_id: user2.id)
relation.save


get '/' do
	erb :index
end
 
post '/submit' do
	rando = Random.rand(3)
	user1 = User.where(handle: "Test#{rando.to_s} Follower").first#Replace with code that identifies the logged-in user
	user2 = User.where(handle: params[:followee]).first
	if user1 == nil || user2 == nil
		"One of you doesn't exist."
	elsif user1 == user2
		"You can't follow yourself!"
	elsif Follow.where(follower_id: user1.id, followee_id: user2.id).first != nil
		"You're already following this person!"
	else
		@relationship = Follow.new(follower_id: user1.id, followee_id: user2.id)
		if @relationship.save
			redirect :followlists
		else
			"Sorry, there was an error!"
		end
	end
end

get '/followlists' do
	@followers = Follow.return_followers(User.where(handle: "Carl"))
	@followees = Follow.return_followees(User.where(handle: "Test2 Follower"))
	@relationships = Follow.return_relationships()
	erb :followlists
end