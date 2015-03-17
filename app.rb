require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/user'      
require './models/follow_relationship'

##TEST CODE
User.delete_all
Follow_Relationship.delete_all
##DELETE BEFORE IMPLEMENTATION

##Start of user test. Delete the test in the final product.
#Creates test users
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
		
#puts User.where(handle: "Paul").first.handle
#puts User.where(handle: "Carl").first.id
##End of user test
	
##Follow test. Also delete this.
user1 = User.where(handle: "Paul").first
user2 = User.where(handle: "Carl").first
#puts user1.id
#puts user2.id
	
relation = Follow_Relationship.new(follower_id: user1.id, followee_id: user2.id)
relation.save
	
#test_relation = Follow_Relationship.where(follower_id: user1.id, followee_id: user2.id).first
#puts test_relation.follower_id
#puts test_relation.followee_id
##End of follow test

get '/' do
	erb :index
end
 
post '/submit' do
	rando = Random.rand(3)
	user1 = User.where(handle: "Test#{rando.to_s} Follower").first#Replace with code that identifies the logged-in user
	user2 = User.where(handle: params[:followee]).first
	if user1 == user2
		"You can't follow yourself!"
	elsif Follow_Relationship.where(follower_id: user1.id, followee_id: user2.id).first != nil
		"You're already following this person!"
	else
		@relationship = Follow_Relationship.new(follower_id: user1.id, followee_id: user2.id)
		if @relationship.save
			redirect :followlists
		else
			"Sorry, there was an error!"
		end
	end
end

get '/followlists' do
	@followers = Follow_Relationship.return_followers(User.where(handle: "Carl"))
	@followees = Follow_Relationship.return_followees(User.where(handle: "Test2 Follower"))
	@relationships = Follow_Relationship.return_relationships()
	erb :followlists
end